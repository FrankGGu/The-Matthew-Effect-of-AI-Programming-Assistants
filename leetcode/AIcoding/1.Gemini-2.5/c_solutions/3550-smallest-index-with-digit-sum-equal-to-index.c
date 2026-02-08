int sumDigits(int n) {
    int sum = 0;
    if (n == 0) return 0; // Handle the case for n=0 specifically as the loop won't run
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int smallestEqual(int* nums, int numsSize) {
    for (int i = 0; i < numsSize; i++) {
        if (i % 10 == nums[i]) {
            return i;
        }
    }
    return -1;
}