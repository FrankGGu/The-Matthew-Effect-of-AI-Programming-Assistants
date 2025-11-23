int sumImbalanceNumbers(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        int seen[1002] = {0};
        int imbalance = 0;
        seen[nums[i]] = 1;
        int minVal = nums[i];
        int maxVal = nums[i];

        for (int j = i + 1; j < numsSize; j++) {
            int x = nums[j];
            if (seen[x]) {
                total += imbalance;
                continue;
            }

            seen[x] = 1;
            if (x < minVal) {
                if (minVal - x > 1) imbalance++;
                minVal = x;
            } else if (x > maxVal) {
                if (x - maxVal > 1) imbalance++;
                maxVal = x;
            } else {
                if (seen[x - 1] && seen[x + 1]) imbalance--;
                else if (!seen[x - 1] && !seen[x + 1]) imbalance++;
            }
            total += imbalance;
        }
    }
    return total;
}