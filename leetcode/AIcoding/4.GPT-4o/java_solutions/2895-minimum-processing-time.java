class Solution {
    public long minProcessingTime(int[] tasks) {
        Arrays.sort(tasks);
        long totalTime = 0;
        long currentTime = 0;

        for (int task : tasks) {
            currentTime += task;
            totalTime += currentTime;
        }

        return totalTime;
    }
}