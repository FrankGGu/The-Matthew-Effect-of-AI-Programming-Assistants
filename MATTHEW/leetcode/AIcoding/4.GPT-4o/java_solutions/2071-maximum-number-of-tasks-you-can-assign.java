class Solution {
    public int maxTasks(int[] tasks, int maxTime) {
        Arrays.sort(tasks);
        int count = 0, totalTime = 0;
        for (int task : tasks) {
            if (totalTime + task <= maxTime) {
                totalTime += task;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
}