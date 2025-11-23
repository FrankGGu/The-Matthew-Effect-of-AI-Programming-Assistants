int count;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int isPerfectSquare(int x) {
    int root = sqrt(x);
    return root * root == x;
}

void backtrack(int* nums, int start, int n) {
    if (start == n) {
        count++;
        return;
    }

    for (int i = start; i < n; i++) {
        if (i != start && nums[i] == nums[start]) continue;
        swap(&nums[start], &nums[i]);
        if (start == 0 || isPerfectSquare(nums[start] + nums[start - 1])) {
            backtrack(nums, start + 1, n);
        }
        swap(&nums[start], &nums[i]);
    }
}

int numSquarefulPerms(int* nums, int numsSize) {
    count = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (nums[j] > nums[j + 1]) {
                int temp = nums[j];
                nums[j] = nums[j + 1];
                nums[j + 1] = temp;
            }
        }
    }
    backtrack(nums, 0, numsSize);
    return count;
}