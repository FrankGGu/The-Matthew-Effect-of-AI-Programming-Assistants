/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
double* sampleStats(int* count, int countSize, int* returnSize) {
    double* result = (double*)malloc(5 * sizeof(double));
    *returnSize = 5;

    // Initialize with impossible values
    result[0] = -1; // minimum
    result[1] = -1; // maximum
    result[2] = 0;  // mean
    result[3] = 0;  // median
    result[4] = 0;  // mode

    long total = 0;
    long sum = 0;
    int maxCount = 0;

    // Find min, max, total count, sum, and mode
    for (int i = 0; i < countSize; i++) {
        if (count[i] > 0) {
            if (result[0] == -1) {
                result[0] = i;
            }
            result[1] = i;

            total += count[i];
            sum += (long)count[i] * i;

            if (count[i] > maxCount) {
                maxCount = count[i];
                result[4] = i;
            }
        }
    }

    // Calculate mean
    result[2] = (double)sum / total;

    // Calculate median
    int medianPos1 = (total + 1) / 2;
    int medianPos2 = (total + 2) / 2;
    long currentCount = 0;
    double medianSum = 0;
    int medianCount = 0;

    for (int i = 0; i < countSize; i++) {
        if (count[i] > 0) {
            long prevCount = currentCount;
            currentCount += count[i];

            if (medianCount < 2 && prevCount < medianPos1 && currentCount >= medianPos1) {
                medianSum += i;
                medianCount++;
            }
            if (medianCount < 2 && prevCount < medianPos2 && currentCount >= medianPos2) {
                medianSum += i;
                medianCount++;
            }

            if (medianCount == 2) {
                break;
            }
        }
    }

    result[3] = medianSum / 2.0;

    return result;
}