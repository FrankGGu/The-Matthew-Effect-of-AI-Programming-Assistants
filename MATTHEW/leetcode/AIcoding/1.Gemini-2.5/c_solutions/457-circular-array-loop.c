#include <stdbool.h>

int getNext(int* nums, int n, int current_idx, bool current_direction) {
    if (nums[current_idx] == 0) {
        return -1;
    }

    bool next_direction = nums[current_idx] > 0;
    if (next_direction != current_direction) {
        return -1;
    }

    int next_idx = (current_idx + nums[current_idx]) % n;
    if (next_idx < 0) {
        next_idx += n;
    }

    if (next_idx == current_idx) {
        return -1;
    }

    return next_idx;
}

bool circularArrayLoop(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return false;
    }

    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] == 0) {
            continue;
        }

        int slow = i;
        int fast = i;
        bool current_direction = nums[i] > 0;

        while (true) {
            slow = getNext(nums, numsSize, slow, current_direction);
            if (slow == -1) {
                break;
            }

            fast = getNext(nums, numsSize, fast, current_direction);
            if (fast == -1) {
                break;
            }
            fast = getNext(nums, numsSize, fast, current_direction);
            if (fast == -1) {
                break;
            }

            if (slow == fast) {
                return true;
            }
        }

        int current = i;
        while (true) {
            if (nums[current] == 0) {
                break;
            }

            int next_idx = (current + nums[current]) % numsSize;
            if (next_idx < 0) {
                next_idx += numsSize;
            }

            if ((nums[current] > 0) != current_direction || next_idx == current) {
                nums[current] = 0;
                break;
            }

            int temp_next = next_idx;
            nums[current] = 0;
            current = temp_next;
        }
    }

    return false;
}