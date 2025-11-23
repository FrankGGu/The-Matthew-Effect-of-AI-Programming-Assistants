int maxDivScore(int* nums, int numsSize, int* divisors, int divisorsSize) {
    int maxScore = -1;
    int result = 0;

    for (int i = 0; i < divisorsSize; i++) {
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] % divisors[i] == 0) {
                count++;
            }
        }

        if (count > maxScore) {
            maxScore = count;
            result = divisors[i];
        } else if (count == maxScore && divisors[i] < result) {
            result = divisors[i];
        }
    }

    return result;
}