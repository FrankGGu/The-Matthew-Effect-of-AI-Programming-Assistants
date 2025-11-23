#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool isCircular(int* nums, int numsSize) {
    if (nums == NULL || numsSize <= 0) return false;

    bool* visited = (bool*)malloc(numsSize * sizeof(bool));
    for (int i = 0; i < numsSize; i++) {
        visited[i] = false;
    }

    for (int i = 0; i < numsSize; i++) {
        if (visited[i]) continue;

        int slow = i;
        int fast = i;
        bool direction = nums[slow] > 0;

        while (true) {
            if (visited[slow]) break;
            visited[slow] = true;

            int nextSlow = (slow + nums[slow]) % numsSize;
            if (nextSlow < 0) nextSlow += numsSize;
            if ((nums[nextSlow] > 0) != direction) break;

            slow = nextSlow;

            int nextFast = (fast + nums[fast]) % numsSize;
            if (nextFast < 0) nextFast += numsSize;
            if ((nums[nextFast] > 0) != direction) break;
            fast = nextFast;

            nextFast = (fast + nums[fast]) % numsSize;
            if (nextFast < 0) nextFast += numsSize;
            if ((nums[nextFast] > 0) != direction) break;
            fast = nextFast;

            if (slow == fast) {
                if (slow == (slow + nums[slow]) % numsSize) {
                    free(visited);
                    return true;
                }
            }
        }
    }

    free(visited);
    return false;
}

bool hasCycle(int* nums, int numsSize) {
    return isCircular(nums, numsSize);
}