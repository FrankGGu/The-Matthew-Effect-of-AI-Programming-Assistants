int jump(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    int jumps = 0;
    int current_reach = 0;
    int farthest_reach = 0;

    for (int i = 0; i < numsSize - 1; ++i) {
        if (i + nums[i] > farthest_reach) {
            farthest_reach = i + nums[i];
        }

        if (i == current_reach) {
            jumps++;
            current_reach = farthest_reach;

            if (current_reach >= numsSize - 1) {
                break;
            }
        }
    }

    return jumps;
}