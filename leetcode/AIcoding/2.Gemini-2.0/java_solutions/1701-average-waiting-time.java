class Solution {
    public double averageWaitingTime(int[][] customers) {
        long totalWaitingTime = 0;
        long currentTime = 0;

        for (int[] customer : customers) {
            int arrivalTime = customer[0];
            int serviceTime = customer[1];

            if (currentTime <= arrivalTime) {
                currentTime = arrivalTime + serviceTime;
                totalWaitingTime += serviceTime;
            } else {
                currentTime += serviceTime;
                totalWaitingTime += (currentTime - arrivalTime);
            }
        }

        return (double) totalWaitingTime / customers.length;
    }
}