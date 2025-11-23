class Solution {
    public int[] getOrder(int[][] tasks) {
        int n = tasks.length;
        int[][] indexedTasks = new int[n][3];
        for (int i = 0; i < n; i++) {
            indexedTasks[i][0] = tasks[i][0];
            indexedTasks[i][1] = tasks[i][1];
            indexedTasks[i][2] = i;
        }
        Arrays.sort(indexedTasks, (a, b) -> a[0] - b[0]);

        PriorityQueue<int[]> minHeap = new PriorityQueue<>((a, b) -> a[0] == b[0] ? a[2] - b[2] : a[0] - b[0]);
        int[] result = new int[n];
        int index = 0, time = 0, i = 0;

        while (index < n) {
            while (i < n && indexedTasks[i][0] <= time) {
                minHeap.offer(new int[]{indexedTasks[i][1], indexedTasks[i][2]});
                i++;
            }
            if (minHeap.isEmpty()) {
                time = indexedTasks[i][0];
            } else {
                int[] task = minHeap.poll();
                result[index++] = task[1];
                time += task[0];
            }
        }

        return result;
    }
}