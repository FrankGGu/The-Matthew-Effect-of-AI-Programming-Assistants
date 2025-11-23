int countMatchingSubarrays(int* nums, int numsSize, int* pattern, int patternSize) {
    int count = 0;
    int requiredSubarrayLength = patternSize + 1;

    if (numsSize < requiredSubarrayLength) {
        return 0;
    }

    for (int i = 0; i <= numsSize - requiredSubarrayLength; ++i) {
        int currentMatch = 1; // Assume it's a match until proven otherwise
        for (int k = 0; k < patternSize; ++k) {
            int num1 = nums[i + k];
            int num2 = nums[i + k + 1];
            int pVal = pattern[k];

            if (pVal == 0) {
                if (num2 != num1) {
                    currentMatch = 0;
                    break;
                }
            } else if (pVal == 1) {
                if (num2 <= num1) {
                    currentMatch = 0;
                    break;
                }
            } else { // pVal == -1
                if (num2 >= num1) {
                    currentMatch = 0;
                    break;
                }
            }
        }
        if (currentMatch) {
            count++;
        }
    }

    return count;
}