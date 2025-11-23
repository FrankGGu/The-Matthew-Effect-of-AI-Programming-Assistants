import java.util.Arrays;
import java.util.PriorityQueue;

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

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> (a[1] == b[1] ? a[2] - b[2] : a[1] - b[1]));
        int[] result = new int[n];
        int taskIndex = 0;
        int resultIndex = 0;
        long currentTime = 0;

        while (resultIndex < n) {
            while (taskIndex < n && indexedTasks[taskIndex][0] <= currentTime) {
                pq.offer(indexedTasks[taskIndex]);
                taskIndex++;
            }

            if (pq.isEmpty()) {
                if (taskIndex < n) {
                    currentTime = indexedTasks[taskIndex][0];
                    while (taskIndex < n && indexedTasks[taskIndex][0] <= currentTime) {
                        pq.offer(indexedTasks[taskIndex]);
                        taskIndex++;
                    }
                } else {
                    break;
                }
            }

            int[] currentTask = pq.poll();
            result[resultIndex++] = currentTask[2];
            currentTime += currentTask[1];
        }

        return result;
    }
}