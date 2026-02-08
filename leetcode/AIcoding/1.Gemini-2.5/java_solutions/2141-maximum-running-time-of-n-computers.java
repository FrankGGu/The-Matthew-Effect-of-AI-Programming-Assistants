class Solution {
    public long maxRunTime(int n, int[] batteries) {
        long low = 0;
        long high = 0;
        for (int b : batteries) {
            high += b;
        }
        high /= n; // Maximum possible average time for each computer

        long ans = 0;

        while (low <= high) {
            long mid = low + (high - low) / 2;

            if (check(mid, n, batteries)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private boolean check(long T, int n, int[] batteries) {
        // If T is 0, it's always possible to run for 0 minutes.
        if (T == 0) {
            return true;
        }

        long availablePower = 0; // Total power from batteries smaller than T, and excess from batteries larger than T
        int computersPoweredDirectly = 0; // Number of computers that can be fully powered by a single battery >= T

        for (int b : batteries) {
            if (b >= T) {
                computersPoweredDirectly++;
                availablePower += (b - T); // Add excess power to the pool
            } else {
                availablePower += b; // Add entire battery capacity to the pool
            }
        }

        // We have 'computersPoweredDirectly' computers fully powered.
        // We need to power 'n - computersPoweredDirectly' more computers.
        // Each of these remaining computers needs 'T' minutes.
        // The total minutes required for these remaining computers is (n - computersPoweredDirectly) * T.
        // We have 'availablePower' from the pool.
        // If 'n - computersPoweredDirectly' is negative or zero, it means all 'n' computers are already powered.
        // So, we need to check if availablePower is enough for Math.max(0, n - computersPoweredDirectly) computers.
        long computersRemaining = n - computersPoweredDirectly;
        if (computersRemaining <= 0) {
            return true; 
        }

        // Check if the accumulated availablePower can cover the remaining computers' needs
        return availablePower >= computersRemaining * T;
    }
}