class Solution {
    public int minOperationsMaxProfit(int[] customers, int boardingCost, int runningCost) {
        int totalCustomersWaiting = 0;
        int currentProfit = 0;
        int maxProfit = 0; // Stores the maximum profit encountered that is greater than 0, or 0 if only negative/zero profits
        int maxProfitRotation = -1; // Stores the rotation number for maxProfit

        int rotationCount = 0;
        int customerIndex = 0;

        // Simulate the wheel operation
        // Continue as long as there are customers arriving or customers waiting
        while (customerIndex < customers.length || totalCustomersWaiting > 0) {
            // Step 1: Customers arrive
            if (customerIndex < customers.length) {
                totalCustomersWaiting += customers[customerIndex];
                customerIndex++;
            }

            // If no customers are waiting and no more customers will arrive, stop rotations
            if (totalCustomersWaiting == 0 && customerIndex >= customers.length) {
                break;
            }

            // Step 2: Wheel rotates
            rotationCount++;

            // Step 3: Board customers (up to 4)
            int boardedCustomers = Math.min(4, totalCustomersWaiting);
            totalCustomersWaiting -= boardedCustomers;

            // Step 4: Calculate profit for this rotation
            currentProfit += boardedCustomers * boardingCost - runningCost;

            // Step 5: Update maximum profit if current profit is higher
            // We want the smallest rotation number for the maximum profit.
            // So, only update if currentProfit is strictly greater than maxProfit.
            if (currentProfit > maxProfit) {
                maxProfit = currentProfit;
                maxProfitRotation = rotationCount;
            }
        }

        return maxProfitRotation;
    }
}