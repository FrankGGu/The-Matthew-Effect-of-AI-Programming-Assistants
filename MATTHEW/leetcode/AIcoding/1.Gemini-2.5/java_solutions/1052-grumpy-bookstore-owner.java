class Solution {
    public int maxSatisfied(int[] customers, int[] grumpy, int minutes) {
        int n = customers.length;
        int baseSatisfiedCustomers = 0;

        // Calculate initially satisfied customers (when owner is not grumpy)
        for (int i = 0; i < n; i++) {
            if (grumpy[i] == 0) {
                baseSatisfiedCustomers += customers[i];
            }
        }

        int maxAdditionalCustomers = 0;
        int currentWindowCustomers = 0;

        // Calculate additional customers for the first window of 'minutes'
        for (int i = 0; i < minutes; i++) {
            if (grumpy[i] == 1) {
                currentWindowCustomers += customers[i];
            }
        }
        maxAdditionalCustomers = currentWindowCustomers;

        // Slide the window
        for (int i = minutes; i < n; i++) {
            // Remove the customer from the left end of the window if grumpy
            if (grumpy[i - minutes] == 1) {
                currentWindowCustomers -= customers[i - minutes];
            }
            // Add the customer from the right end of the window if grumpy
            if (grumpy[i] == 1) {
                currentWindowCustomers += customers[i];
            }
            maxAdditionalCustomers = Math.max(maxAdditionalCustomers, currentWindowCustomers);
        }

        return baseSatisfiedCustomers + maxAdditionalCustomers;
    }
}