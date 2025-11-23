void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void reverse(int* nums, int start, int end) {
    while (start < end) {
        swap(&nums[start], &nums[end]);
        start++;
        end--;
    }
}

void nextPermutation(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return;
    }

    int k = -1;
    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] < nums[i + 1]) {
            k = i;
            break;
        }
    }

    if (k == -1) {
        reverse(nums, 0, numsSize - 1);
        return;
    }

    int l = -1;
    for (int i = numsSize - 1; i > k; i--) {
        if (nums[i] > nums[k]) {
            l = i;
            break;
        }
    }

    swap(&nums[k], &nums[l]);

    reverse(nums, k + 1, numsSize - 1);
}