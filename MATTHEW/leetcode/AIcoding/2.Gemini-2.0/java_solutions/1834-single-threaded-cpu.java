import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] getOrder(int[][] tasks) {
        int n = tasks.length;
        int[][] augmentedTasks = new int[n][3];
        for (int i = 0; i < n; i++) {
            augmentedTasks[i][0] = tasks[i][0];
            augmentedTasks[i][1] = tasks[i][1];
            augmentedTasks[i][2] = i;
        }
        Arrays.sort(augmentedTasks, (a, b) -> a[0] - b[0]);

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> (a[1] == b[1] ? a[2] - b[2] : a[1] - b[1]));

        int[] result = new int[n];
        int time = 0;
        int taskIndex = 0;
        int resultIndex = 0;

        while (resultIndex < n) {
            while (taskIndex < n && augmentedTasks[taskIndex][0] <= time) {
                pq.offer(augmentedTasks[taskIndex]);
                taskIndex++;
            }

            if (pq.isEmpty()) {
                if (taskIndex < n) {
                    time = augmentedTasks[taskIndex][0];
                } else {
                    break;
                }

                while (taskIndex < n && augmentedTasks[taskIndex][0] <= time) {
                    pq.offer(augmentedTasks[taskIndex]);
                    taskIndex++;
                }
            }

            int[] currentTask = pq.poll();
            result[resultIndex++] = currentTask[2];
            time += currentTask[1];
        }

        return result;
    }
}