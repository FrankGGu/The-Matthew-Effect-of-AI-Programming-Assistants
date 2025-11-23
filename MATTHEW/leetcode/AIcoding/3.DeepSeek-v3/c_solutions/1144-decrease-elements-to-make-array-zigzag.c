int movesToMakeZigzag(int* nums, int numsSize) {
    int evenMoves = 0, oddMoves = 0;

    for (int i = 0; i < numsSize; i++) {
        int left = (i > 0) ? nums[i - 1] : 1001;
        int right = (i < numsSize - 1) ? nums[i + 1] : 1001;
        int minAdj = (left < right) ? left : right;

        if (i % 2 == 0) {
            if (nums[i] >= minAdj) {
                evenMoves += nums[i] - minAdj + 1;
            }
        } else {
            if (nums[i] >= minAdj) {
                oddMoves += nums[i] - minAdj + 1;
            }
        }
    }

    return (evenMoves < oddMoves) ? evenMoves : oddMoves;
}