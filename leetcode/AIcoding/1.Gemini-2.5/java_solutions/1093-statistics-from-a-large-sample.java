class Solution {
    public double[] sampleStats(int[] count) {
        double min = -1.0;
        double max = -1.0;
        double mean = 0.0;
        double median = 0.0;
        double mode = 0.0;

        long totalElements = 0;
        long sumOfElements = 0;
        int maxFrequency = 0;

        // Calculate min, max, totalElements, sumOfElements, maxFrequency, and find the mode value
        for (int i = 0; i < 256; i++) {
            if (count[i] > 0) {
                // Min
                if (min == -1.0) { // First element found
                    min = i;
                }
                // Max (will be updated to the last element found)
                max = i;

                // Sum and total count
                totalElements += count[i];
                sumOfElements += (long)i * count[i];

                // Mode
                if (count[i] > maxFrequency) {
                    maxFrequency = count[i];
                    mode = i;
                }
            }
        }

        // Mean
        // Problem states sample is not empty, so totalElements > 0.
        mean = (double)sumOfElements / totalElements;

        // Median
        long targetIndex1 = (totalElements - 1) / 2;
        long targetIndex2 = totalElements / 2;

        int val1 = -1;
        int val2 = -1;
        long elementsPassed = 0;

        for (int i = 0; i < 256; i++) {
            if (count[i] > 0) {
                // Check if targetIndex1 falls within the current range of values `i`
                if (val1 == -1 && elementsPassed + count[i] > targetIndex1) {
                    val1 = i;
                }
                // Check if targetIndex2 falls within the current range of values `i`
                if (val2 == -1 && elementsPassed + count[i] > targetIndex2) {
                    val2 = i;
                }
                elementsPassed += count[i];
                // Optimization: if both values are found, no need to continue iterating
                if (val1 != -1 && val2 != -1) {
                    break;
                }
            }
        }
        median = (double)(val1 + val2) / 2.0;

        return new double[]{min, max, mean, median, mode};
    }
}