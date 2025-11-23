int maxEvenOdd(int* nums, int numsSize) {
    int even_frequency = 0;
    int odd_frequency = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            even_frequency++;
        } else {
            odd_frequency++;
        }
    }

    return even_frequency - odd_frequency;
}