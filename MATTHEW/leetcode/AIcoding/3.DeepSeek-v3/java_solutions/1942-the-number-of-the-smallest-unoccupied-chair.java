class Solution {
    public int smallestChair(int[][] times, int targetFriend) {
        int n = times.length;
        int[][] events = new int[2 * n][3];
        for (int i = 0; i < n; ++i) {
            events[2 * i] = new int[]{times[i][0], 1, i};
            events[2 * i + 1] = new int[]{times[i][1], 0, i};
        }
        Arrays.sort(events, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });
        PriorityQueue<Integer> available = new PriorityQueue<>();
        for (int i = 0; i < n; ++i) {
            available.offer(i);
        }
        Map<Integer, Integer> occupied = new HashMap<>();
        for (int[] event : events) {
            int time = event[0], type = event[1], friend = event[2];
            if (type == 0) {
                int chair = occupied.get(friend);
                available.offer(chair);
                occupied.remove(friend);
            } else {
                int chair = available.poll();
                occupied.put(friend, chair);
                if (friend == targetFriend) {
                    return chair;
                }
            }
        }
        return -1;
    }
}