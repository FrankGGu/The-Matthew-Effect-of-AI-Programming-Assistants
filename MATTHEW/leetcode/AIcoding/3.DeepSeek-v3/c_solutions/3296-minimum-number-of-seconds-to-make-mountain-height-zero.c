int isPossible(long long* nums, int numsSize, long long maxOps, int target) {
    long long ops = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > target) {
            long long diff = nums[i] - target;
            ops += diff;
            if (ops > maxOps) return 0;
        }
    }
    return ops <= maxOps;
}

int minimumTime(int* mountain, int mountainSize) {
    long long left = 0, right = 0;
    for (int i = 0; i < mountainSize; i++) {
        if (mountain[i] > right) right = mountain[i];
    }

    long long answer = right;
    while (left <= right) {
        long long mid = left + (right - left) / 2;
        if (isPossible((long long*)mountain, mountainSize, mid, mid)) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return (int)answer;
}