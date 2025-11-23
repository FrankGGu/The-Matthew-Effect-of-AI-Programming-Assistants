long long maxAlternatingSum(int* nums, int numsSize) {
    long long even = 0, odd = 0;
    for (int i = 0; i < numsSize; i++) {
        long long newEven = fmax(even, odd + nums[i]);
        long long newOdd = fmax(odd, even - nums[i]);
        even = newEven;
        odd = newOdd;
    }
    return even;
}