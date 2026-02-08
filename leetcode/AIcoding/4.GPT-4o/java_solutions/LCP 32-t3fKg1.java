class Solution {
    public int[] processTasks(int[][] tasks) {
        int n = tasks.length;
        int[] result = new int[n];
        Arrays.sort(tasks, (a, b) -> a[1] - b[1]);

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        int time = 0;
        int index = 0;

        for (int i = 0; i < n; i++) {
            while (index < n && tasks[index][1] <= time) {
                pq.offer(new int[]{tasks[index][0], tasks[index][1]});
                index++;
            }
            if (!pq.isEmpty()) {
                int[] task = pq.poll();
                result[i] = task[0];
                time += task[0];
            } else {
                time = tasks[index][1];
                i--;
            }
        }
        return result;
    }
}