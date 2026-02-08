public class Solution {
    public int maxMaximizedCustomers(int[] customers, int[] grumpy, int X) {
        int n = customers.length;
        int maxCustomers = 0;
        int currentCustomers = 0;

        for (int i = 0; i < n; i++) {
            if (grumpy[i] == 0) {
                currentCustomers += customers[i];
            }
        }

        maxCustomers = currentCustomers;

        for (int i = 0; i < X; i++) {
            if (grumpy[i] == 1) {
                currentCustomers += customers[i];
            }
        }

        maxCustomers = Math.max(maxCustomers, currentCustomers);

        for (int i = X; i < n; i++) {
            if (grumpy[i - X] == 1) {
                currentCustomers -= customers[i - X];
            }
            if (grumpy[i] == 1) {
                currentCustomers += customers[i];
            }
            maxCustomers = Math.max(maxCustomers, currentCustomers);
        }

        return maxCustomers;
    }
}