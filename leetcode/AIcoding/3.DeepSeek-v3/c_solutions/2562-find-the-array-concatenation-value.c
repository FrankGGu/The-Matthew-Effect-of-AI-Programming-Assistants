long long findTheArrayConcVal(int* nums, int numsSize) {
    long long sum = 0;
    int left = 0, right = numsSize - 1;

    while (left <= right) {
        if (left == right) {
            sum += nums[left];
        } else {
            long long concat = nums[left];
            int temp = nums[right];
            while (temp > 0) {
                concat *= 10;
                temp /= 10;
            }
            concat += nums[right];
            sum += concat;
        }
        left++;
        right--;
    }

    return sum;
}