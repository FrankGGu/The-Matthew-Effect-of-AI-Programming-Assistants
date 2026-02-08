class Solution {
    public int rectangleArea(int[][] rectangles) {
        int MOD = 1_000_000_007;
        List<int[]> events = new ArrayList<>();
        for (int[] rec : rectangles) {
            events.add(new int[]{rec[1], 1, rec[0], rec[2]});
            events.add(new int[]{rec[3], -1, rec[0], rec[2]});
        }
        Collections.sort(events, (a, b) -> Integer.compare(a[0], b[0]));

        List<int[]> active = new ArrayList<>();
        int prevY = events.get(0)[0];
        long res = 0;
        for (int[] event : events) {
            int y = event[0], typ = event[1], x1 = event[2], x2 = event[3];
            long query = 0;
            int curr = -1;
            for (int[] interval : active) {
                curr = Math.max(curr, interval[0]);
                query += Math.max(interval[1] - curr, 0);
                curr = Math.max(curr, interval[1]);
            }
            res += query * (y - prevY);
            res %= MOD;

            if (typ == 1) {
                active.add(new int[]{x1, x2});
                Collections.sort(active, (a, b) -> Integer.compare(a[0], b[0]));
            } else {
                for (int i = 0; i < active.size(); i++) {
                    if (active.get(i)[0] == x1 && active.get(i)[1] == x2) {
                        active.remove(i);
                        break;
                    }
                }
            }
            prevY = y;
        }
        return (int) res;
    }
}