int minDeletions(int* nums, int numsSize) {
    int count[100001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int deletions = 0;
    int used[100001] = {0};

    for (int i = 0; i < 100001; i++) {
        if (count[i] > 0) {
            while (used[count[i]] > 0) {
                deletions++;
                count[i]--;
            }
            used[count[i]]++;
        }
    }

    return deletions;
}