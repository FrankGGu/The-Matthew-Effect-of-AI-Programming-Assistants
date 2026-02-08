import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] getOrder(int[][] tasks) {
        int n = tasks.length;
        // augmentedTasks stores [enqueueTime, processingTime, originalIndex]
        int[][] augmentedTasks = new int[n][3]; 

        for (int i = 0; i < n; i++) {
            augmentedTasks[i][0] = tasks[i][0]; // enqueueTime
            augmentedTasks[i][1] = tasks[i][1]; // processingTime
            augmentedTasks[i][2] = i;           // originalIndex
        }

        // Sort tasks primarily by enqueueTime.
        // This ensures we always consider tasks in the order they become available.
        Arrays.sort(augmentedTasks, (a, b) -> Integer.compare(a[0], b[0]));

        // PriorityQueue for tasks that are currently available to be processed.
        // It stores [processingTime, originalIndex].
        // Tasks are ordered by processingTime (ascending), then by originalIndex (ascending) for tie-breaking.
        PriorityQueue<int[]> availableTasks = new PriorityQueue<>(
            (a, b) -> {
                if (a[0] != b[0]) {
                    return Integer.compare(a[0], b[0]); // Sort by processingTime
                }
                return Integer.compare(a[1], b[1]); // Sort by originalIndex for tie-breaking
            }
        );

        int[] result = new int[n];
        long currentTime = 0; // Use long to prevent overflow for total processing time
        int taskPtr = 0;      // Pointer for iterating through the sorted augmentedTasks
        int resultPtr = 0;    // Pointer for filling the result array

        while (resultPtr < n) {
            // Add all tasks whose enqueueTime <= currentTime to the priority queue
            // These tasks are now "available" for processing.
            while (taskPtr < n && augmentedTasks[taskPtr][0] <= currentTime) {
                availableTasks.offer(new int[]{augmentedTasks[taskPtr][1], augmentedTasks[taskPtr][2]});
                taskPtr++;
            }

            // If the CPU is idle (no tasks in availableTasks) AND there are still tasks to be enqueued,
            // advance currentTime to the enqueueTime of the next task.
            if (availableTasks.isEmpty()) {
                // This happens when all currently available tasks are processed,
                // and the CPU is waiting for the next task to arrive.
                // We must jump currentTime forward to the enqueueTime of the next task.
                // taskPtr will be < n if there are still tasks to process.
                currentTime = Math.max(currentTime, (long)augmentedTasks[taskPtr][0]);
                // After advancing time, the loop will re-evaluate and potentially add new tasks
                // that are now available to the priority queue.
                continue; 
            }

            // Process the next task from the priority queue (highest priority task)
            int[] nextTask = availableTasks.poll();
            currentTime += nextTask[0]; // Update current time by adding processing time
            result[resultPtr++] = nextTask[1]; // Add the original index to the result array
        }

        return result;
    }
}