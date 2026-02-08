int* searchRange(int* nums, int numsSize, int target, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;
    *returnSize = 2;

    if (numsSize == 0) return result;

    int left = 0, right = numsSize - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (nums[mid] < target) {
            left = mid + 1;
        } else if (nums[mid] > target) {
            right = mid - 1;
        } else {
            int start = mid, end = mid;

            while (start > 0 && nums[start - 1] == target) {
                start--;
            }
            while (end < numsSize - 1 && nums[end + 1] == target) {
                end++;
            }

            result[0] = start;
            result[1] = end;
            return result;
        }
    }

    return result;
}