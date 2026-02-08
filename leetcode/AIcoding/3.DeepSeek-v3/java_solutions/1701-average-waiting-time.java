class Solution {
    public double averageWaitingTime(int[][] customers) {
        double totalWaitingTime = 0;
        int currentTime = 0;

        for (int[] customer : customers) {
            int arrivalTime = customer[0];
            int preparationTime = customer[1];

            if (currentTime < arrivalTime) {
                currentTime = arrivalTime;
            }

            currentTime += preparationTime;
            totalWaitingTime += currentTime - arrivalTime;
        }

        return totalWaitingTime / customers.length;
    }
}