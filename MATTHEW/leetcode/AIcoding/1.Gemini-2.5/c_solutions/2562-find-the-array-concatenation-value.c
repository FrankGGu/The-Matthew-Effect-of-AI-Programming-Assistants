long long findTheArrayConcatenationValue(int* nums, int numsSize) {
    long long concatenationValue = 0;
    int left = 0;
    int right = numsSize - 1;

    while (left <= right) {
        if (left == right) {
            concatenationValue += nums[left];
        } else {
            long long num1 = nums[left];
            long long num2 = nums[right];

            long long powerOf10 = 1;
            long long tempNum2 = num2;

            // Calculate 10 raised to the power of the number of digits in num2
            // This is used to shift num1 to the left by the appropriate number of places
            // If num2 is 0, it has one digit, so powerOf10 should be 10.
            if (tempNum2 == 0) {
                powerOf10 = 10;
            } else {
                while (tempNum2 > 0) {
                    powerOf10 *= 10;
                    tempNum2 /= 10;
                }
            }

            // Concatenate num1 and num2 and add to the total concatenation value
            concatenationValue += num1 * powerOf10 + num2;
        }
        left++;
        right--;
    }

    return concatenationValue;
}