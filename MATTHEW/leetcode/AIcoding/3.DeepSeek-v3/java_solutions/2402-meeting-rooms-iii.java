class Solution {
    public int mostBooked(int n, int[][] meetings) {
        Arrays.sort(meetings, (a, b) -> a[0] - b[0]);
        PriorityQueue<int[]> busy = new PriorityQueue<>((a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);
        PriorityQueue<Integer> idle = new PriorityQueue<>();
        for (int i = 0; i < n; i++) {
            idle.offer(i);
        }
        int[] count = new int[n];
        for (int[] m : meetings) {
            int start = m[0], end = m[1];
            while (!busy.isEmpty() && busy.peek()[0] <= start) {
                idle.offer(busy.poll()[1]);
            }
            if (!idle.isEmpty()) {
                int room = idle.poll();
                count[room]++;
                busy.offer(new int[]{end, room});
            } else {
                int[] curr = busy.poll();
                count[curr[1]]++;
                busy.offer(new int[]{curr[0] + end - start, curr[1]});
            }
        }
        int max = 0, res = 0;
        for (int i = 0; i < n; i++) {
            if (count[i] > max) {
                max = count[i];
                res = i;
            }
        }
        return res;
    }
}