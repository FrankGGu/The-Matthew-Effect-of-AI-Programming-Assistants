char kthCharacter(int k, int* nums, int numsSize, char* s, int m) {
    long long pos = k - 1;
    for (int i = numsSize - 1; i >= 0; i--) {
        int num = nums[i];
        if (pos >= num) {
            pos = pos - num;
        } else {
            pos = pos;
        }
    }
    return s[pos % m];
}