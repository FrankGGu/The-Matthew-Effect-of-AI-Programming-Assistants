int jump(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    int jumps = 0;
    int current_jump_end = 0;
    int farthest_reach = 0;

    for (int i = 0; i < numsSize - 1; i++) {
        // Update the farthest index reachable from any point up to 'i'
        if (i + nums[i] > farthest_reach) {
            farthest_reach = i + nums[i];
        }

        // If 'i' has reached the end of the current jump's range,
        // it means we must make a new jump.
        if (i == current_jump_end) {
            jumps++;
            current_jump_end = farthest_reach;

            // If the new current_jump_end already covers the last index,
            // we have reached the destination, so we can stop.
            if (current_jump_end >= numsSize - 1) {
                break;
            }
        }
    }

    return jumps;
}