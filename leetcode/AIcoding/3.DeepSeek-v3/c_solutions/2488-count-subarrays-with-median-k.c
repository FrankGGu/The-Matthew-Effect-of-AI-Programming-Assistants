int countSubarrays(int* nums, int numsSize, int k) {
    int pos = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == k) {
            pos = i;
            break;
        }
    }

    int* balance = (int*)malloc(sizeof(int) * (2 * numsSize + 1));
    for (int i = 0; i < 2 * numsSize + 1; i++) {
        balance[i] = 0;
    }

    int count = 0;
    int curr = 0;
    balance[numsSize] = 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < k) curr--;
        else if (nums[i] > k) curr++;

        if (i < pos) {
            balance[curr + numsSize]++;
        } else {
            count += balance[curr + numsSize];
            count += balance[curr - 1 + numsSize];
        }
    }

    free(balance);
    return count;
}