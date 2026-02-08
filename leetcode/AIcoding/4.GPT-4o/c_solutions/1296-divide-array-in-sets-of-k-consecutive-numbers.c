bool isPossibleDivide(int* nums, int numsSize, int k) {
    if (numsSize % k != 0) return false;

    int count[10001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    for (int i = 0; i < 10001; i++) {
        while (count[i] > 0) {
            for (int j = 0; j < k; j++) {
                if (count[i + j] == 0) return false;
                count[i + j]--;
            }
        }
    }

    return true;
}