int maximumPrimeDifference(int* nums, int numsSize) {
    int first = -1, last = -1;
    for (int i = 0; i < numsSize; i++) {
        int x = nums[i];
        if (x == 1) continue;
        int isPrime = 1;
        for (int j = 2; j * j <= x; j++) {
            if (x % j == 0) {
                isPrime = 0;
                break;
            }
        }
        if (isPrime) {
            if (first == -1) first = i;
            last = i;
        }
    }
    return last - first;
}