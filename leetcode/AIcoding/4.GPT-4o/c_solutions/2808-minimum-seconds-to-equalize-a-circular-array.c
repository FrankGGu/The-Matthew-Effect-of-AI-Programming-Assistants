int minimumSeconds(int* nums, int numsSize) {
    int max_dist = 0;
    int n = numsSize;

    for (int i = 0; i < n; i++) {
        int dist = 0;
        for (int j = 1; j < n; j++) {
            if (nums[(i + j) % n] == nums[i]) {
                dist = j;
                break;
            }
        }
        max_dist = dist > max_dist ? dist : max_dist;
    }

    return max_dist == 0 ? 0 : (n - max_dist);
}