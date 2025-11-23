#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countArrangement(int n) {
    int count = 0;
    int nums[n];
    for (int i = 0; i < n; i++) {
        nums[i] = i + 1;
    }

    void permute(int index) {
        if (index == n) {
            count++;
            return;
        }

        for (int i = index; i < n; i++) {
            int temp = nums[index];
            nums[index] = nums[i];
            nums[i] = temp;

            if (nums[index] % (index + 1) == 0 || (index + 1) % nums[index] == 0) {
                permute(index + 1);
            }

            temp = nums[index];
            nums[index] = nums[i];
            nums[i] = temp;
        }
    }

    permute(0);
    return count;
}