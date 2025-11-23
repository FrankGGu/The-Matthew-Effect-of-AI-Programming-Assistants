class Solution {
    public int[] kthSmallestPrimeFraction(int[] arr, int k) {
        double low = 0.0;
        double high = 1.0;
        int n = arr.length;

        int[] result = new int[2]; // Stores the best candidate [numerator, denominator]

        // Binary search for the k-th smallest fraction value
        // The loop runs a fixed number of times (e.g., 100 iterations) to achieve desired precision.
        // For typical double precision problems, 100 iterations are often sufficient.
        for (int iter = 0; iter < 100; iter++) { 
            double mid = (low + high) / 2;

            int count = 0; // Number of fractions <= mid

            // To store the largest fraction found so far that is <= mid
            // Initialize with 0/1 to ensure any valid fraction (arr[i]/arr[j] > 0) will be larger
            int maxNumerator = 0;
            int maxDenominator = 1;

            // Two-pointer approach to count fractions <= mid and find the largest one
            // i is the numerator pointer, j is the denominator pointer
            int i = 0;
            for (int j = 1; j < n; j++) {
                // For a fixed arr[j] (denominator), find how many arr[i] (numerators)
                // satisfy arr[i] / arr[j] <= mid, which is arr[i] <= mid * arr[j]
                // The `i < j` condition ensures p < q.
                while (i < j && arr[i] <= mid * arr[j]) {
                    // If current fraction arr[i]/arr[j] is larger than maxNumerator/maxDenominator
                    // (and still <= mid), update maxNumerator and maxDenominator
                    // Use cross-multiplication to avoid floating point precision issues.
                    // (long) cast prevents potential overflow if arr[i] * maxDenominator exceeds Integer.MAX_VALUE.
                    if ((long)arr[i] * maxDenominator > (long)arr[j] * maxNumerator) {
                        maxNumerator = arr[i];
                        maxDenominator = arr[j];
                    }
                    i++;
                }
                // All arr[0]...arr[i-1] form fractions with arr[j] that are <= mid.
                // Add the count of such numerators for the current denominator arr[j].
                count += i;
            }

            if (count == k) {
                // If we found exactly k fractions <= mid, then maxNumerator/maxDenominator
                // is the k-th smallest fraction.
                result[0] = maxNumerator;
                result[1] = maxDenominator;
                return result; // Found the exact answer
            } else if (count < k) {
                // If fewer than k fractions are <= mid, we need a larger fraction value.
                // So, increase the lower bound of our search range.
                low = mid;
            } else { // count > k
                // If more than k fractions are <= mid, we need a smaller fraction value.
                // So, decrease the upper bound of our search range.
                high = mid;
                // When count > k, it means 'mid' is too high. The actual k-th smallest fraction
                // is less than or equal to 'mid'. The 'maxNumerator/maxDenominator' found
                // at this step is the largest fraction p/q that is <= 'mid'. This is a
                // potential candidate for the k-th smallest fraction. By updating 'result' here,
                // we ensure 'result' holds the largest fraction found so far that is <= the current 'high'.
                // This will converge to the k-th smallest fraction.
                result[0] = maxNumerator;
                result[1] = maxDenominator;
            }
        }

        // After the binary search converges, 'result' will hold the k-th smallest fraction.
        return result;
    }
}