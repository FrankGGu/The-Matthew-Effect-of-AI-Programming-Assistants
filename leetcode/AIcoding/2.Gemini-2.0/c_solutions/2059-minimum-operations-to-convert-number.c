#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int* nums, int numsSize, int start, int goal) {
    int queue[10000];
    int head = 0, tail = 0;
    queue[tail++] = start;
    bool visited[1001] = {false};
    visited[start] = true;
    int steps = 0;
    while (head < tail) {
        int size = tail - head;
        for (int i = 0; i < size; i++) {
            int curr = queue[head++];
            if (curr == goal) {
                return steps;
            }
            for (int j = 0; j < numsSize; j++) {
                int next1 = curr + nums[j];
                int next2 = curr - nums[j];
                int next3 = curr ^ nums[j];
                if (next1 >= 0 && next1 <= 1000 && !visited[next1]) {
                    queue[tail++] = next1;
                    visited[next1] = true;
                }
                if (next2 >= 0 && next2 <= 1000 && !visited[next2]) {
                    queue[tail++] = next2;
                    visited[next2] = true;
                }
                if (next3 >= 0 && next3 <= 1000 && !visited[next3]) {
                    queue[tail++] = next3;
                    visited[next3] = true;
                }
                if (next1 == goal || next2 == goal || next3 == goal) return steps + 1;
            }
        }
        steps++;
    }
    return -1;
}