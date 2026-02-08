class Solution {
    public int maxBuilding(int n, int[][] restrictions) {
        List<int[]> list = new ArrayList<>();
        list.add(new int[]{1, 0});
        for (int[] r : restrictions) {
            list.add(r);
        }
        Collections.sort(list, (a, b) -> a[0] - b[0]);

        if (list.get(list.size() - 1)[0] != n) {
            list.add(new int[]{n, n - 1});
        }

        for (int i = 1; i < list.size(); i++) {
            int[] prev = list.get(i - 1);
            int[] curr = list.get(i);
            curr[1] = Math.min(curr[1], prev[1] + (curr[0] - prev[0]));
        }

        for (int i = list.size() - 2; i >= 0; i--) {
            int[] next = list.get(i + 1);
            int[] curr = list.get(i);
            curr[1] = Math.min(curr[1], next[1] + (next[0] - curr[0]));
        }

        int res = 0;
        for (int i = 1; i < list.size(); i++) {
            int[] prev = list.get(i - 1);
            int[] curr = list.get(i);
            int h = (prev[1] + curr[1] + curr[0] - prev[0]) / 2;
            res = Math.max(res, h);
        }

        return res;
    }
}