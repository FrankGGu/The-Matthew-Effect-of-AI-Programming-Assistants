int waysToMakeFair(int* nums, int numsSize) {
    int sumEven = 0, sumOdd = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) sumEven += nums[i];
        else sumOdd += nums[i];
    }

    int result = 0, currEven = 0, currOdd = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            sumEven -= nums[i];
        } else {
            sumOdd -= nums[i];
        }

        if (currEven + sumOdd == currOdd + sumEven) {
            result++;
        }

        if (i % 2 == 0) {
            currEven += nums[i];
        } else {
            currOdd += nums[i];
        }
    }

    return result;
}