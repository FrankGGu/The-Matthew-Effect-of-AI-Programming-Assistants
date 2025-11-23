import java.util.Arrays;

class Solution {
    public int maxNumberOfTrainingPlans(int[] tasks, int[] workers) {
        Arrays.sort(tasks);
        Arrays.sort(workers);

        int taskPointer = 0;
        int workerPointer = 0;
        int count = 0;

        while (taskPointer < tasks.length && workerPointer < workers.length) {
            if (workers[workerPointer] >= tasks[taskPointer]) {
                count++;
                taskPointer++;
                workerPointer++;
            } else {
                workerPointer++;
            }
        }

        return count;
    }
}