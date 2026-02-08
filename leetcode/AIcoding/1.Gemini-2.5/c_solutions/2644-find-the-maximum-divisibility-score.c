int findTheArrayConcVal(int* nums, int numsSize) {
    long long totalConcatenationValue = 0;
    int left = 0;
    int right = numsSize - 1;

    while (left <= right) {
        if (left == right) {
            totalConcatenationValue += nums[left];
        } else {
            long long currentConcatenation;
            int secondNum = nums[right];
            int temp = secondNum;
            int numDigits = 0;
            if (temp == 0) { // Handle case where secondNum is 0
                numDigits = 1;
            } else {
                while (temp > 0) {
                    temp /= 10;
                    numDigits++;
                }
            }

            long long multiplier = 1;
            for (int i = 0; i < numDigits; i++) {
                multiplier *= 10;
            }

            currentConcatenation = (long long)nums[left] * multiplier + secondNum;
            totalConcatenationValue += currentConcatenation;
        }
        left++;
        right--;
    }

    return (int)totalConcatenationValue;
}