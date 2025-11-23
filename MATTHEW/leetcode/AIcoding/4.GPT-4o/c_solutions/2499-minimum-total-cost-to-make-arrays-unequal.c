int minimumTotalCost(int* nums, int numsSize) {
    int totalCost = 0;
    int count[101] = {0}; // Assuming the range of nums is 1 to 100

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    for (int i = 1; i <= 100; i++) {
        if (count[i] > 1) {
            totalCost += (count[i] - 1) * i;
        }
    }

    return totalCost;
}