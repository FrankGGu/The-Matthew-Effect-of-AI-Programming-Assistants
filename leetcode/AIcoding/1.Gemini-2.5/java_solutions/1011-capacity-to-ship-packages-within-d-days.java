class Solution {
    public int shipWithinDays(int[] weights, int days) {
        int low = 0;
        int high = 0;
        for (int weight : weights) {
            low = Math.max(low, weight);
            high += weight;
        }

        int minCapacity = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canShip(weights, days, mid)) {
                minCapacity = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return minCapacity;
    }

    private boolean canShip(int[] weights, int days, int capacity) {
        int daysNeeded = 1;
        int currentWeight = 0;
        for (int weight : weights) {
            if (currentWeight + weight <= capacity) {
                currentWeight += weight;
            } else {
                daysNeeded++;
                currentWeight = weight;
            }
        }
        return daysNeeded <= days;
    }
}