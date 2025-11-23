#include <stdbool.h>

int smallestMissingInteger(int* nums, int numsSize) {
    long long initialSum = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i - 1] + 1) {
            initialSum += nums[i];
        } else {
            break;
        }
    }

    bool seen[1001] = {false};
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] >= 1 && nums[i] <= 1000) {
            seen[nums[i]] = true;
        }
    }

    int x = (int)(initialSum + 1);
    while (true) {
        if (x <= 1000 && seen[x]) {
            x++;
        } else {
            return x;
        }
    }
}