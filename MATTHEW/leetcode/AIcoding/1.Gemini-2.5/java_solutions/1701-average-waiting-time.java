class Solution {
    public double averageWaitingTime(int[][] customers) {
        long totalWaitingTime = 0;
        long currentTime = 0;

        for (int[] customer : customers) {
            long arrivalTime = customer[0];
            long prepareTime = customer[1];

            long startTime = Math.max(currentTime, arrivalTime);
            long finishTime = startTime + prepareTime;
            long waitingTime = finishTime - arrivalTime;

            totalWaitingTime += waitingTime;
            currentTime = finishTime;
        }

        return (double) totalWaitingTime / customers.length;
    }
}