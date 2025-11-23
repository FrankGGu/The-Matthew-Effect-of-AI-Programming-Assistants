import java.util.Arrays;

class Solution {
    public int minWastedSpace(int[] supplies, int[][] packages) {
        final long MOD = 1_000_000_007;

        Arrays.sort(supplies);

        long[] prefixSumSupplies = new long[supplies.length + 1];
        for (int i = 0; i < supplies.length; i++) {
            prefixSumSupplies[i + 1] = prefixSumSupplies[i] + supplies[i];
        }

        long minTotalWastedSpace = Long.MAX_VALUE;

        for (int[] supplierPackages : packages) {
            Arrays.sort(supplierPackages);

            long currentSupplierWastedSpace = 0;
            int supplyIndex = 0; // Pointer to the current supply item to be packaged

            for (int packageSize : supplierPackages) {
                if (supplyIndex == supplies.length) {
                    // All supplies have been packaged
                    break;
                }

                // Find the index of the first supply item that is strictly greater than packageSize.
                // All items from supplies[supplyIndex] to supplies[upperBoundIndex - 1] can be packaged by this packageSize.
                int low = supplyIndex, high = supplies.length;
                while (low < high) {
                    int mid = low + (high - low) / 2;
                    if (supplies[mid] <= packageSize) {
                        low = mid + 1;
                    } else {
                        high = mid;
                    }
                }
                int upperBoundIndex = low; // This is the index of the first item > packageSize

                if (upperBoundIndex > supplyIndex) { // Means this package can package some items
                    long itemsCount = upperBoundIndex - supplyIndex;
                    long sumOfItems = prefixSumSupplies[upperBoundIndex] - prefixSumSupplies[supplyIndex];
                    currentSupplierWastedSpace += itemsCount * packageSize - sumOfItems;
                    supplyIndex = upperBoundIndex;
                }
            }

            // If not all supplies were packaged by this supplier, it's not a valid option.
            if (supplyIndex == supplies.length) {
                minTotalWastedSpace = Math.min(minTotalWastedSpace, currentSupplierWastedSpace);
            }
        }

        if (minTotalWastedSpace == Long.MAX_VALUE) {
            return -1;
        } else {
            return (int) (minTotalWastedSpace % MOD);
        }
    }
}