int[] numberOfPairs(int* nums, int numsSize) {
    int count[101] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int pairs = 0, leftovers = 0;
    for (int i = 0; i < 101; i++) {
        pairs += count[i] / 2;
        leftovers += count[i] % 2;
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = pairs;
    result[1] = leftovers;
    return result;
}