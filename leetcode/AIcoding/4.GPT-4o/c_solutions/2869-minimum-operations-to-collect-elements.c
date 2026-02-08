int minimumOperations(int* nums, int numsSize) {
    int count[101] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }
    int max_count = 0, unique_count = 0;
    for (int i = 1; i <= 100; i++) {
        if (count[i] > 0) {
            unique_count++;
            if (count[i] > max_count) {
                max_count = count[i];
            }
        }
    }
    return unique_count - max_count;
}