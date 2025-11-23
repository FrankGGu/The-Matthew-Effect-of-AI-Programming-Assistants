#include <stdlib.h>

int* memLeak(int memory1, int memory2, int* returnSize) {
    int time = 1;

    while (1) {
        if (memory1 >= time && memory2 >= time) {
            if (memory1 >= memory2) {
                memory1 -= time;
            } else {
                memory2 -= time;
            }
        } else if (memory1 >= time) {
            memory1 -= time;
        } else if (memory2 >= time) {
            memory2 -= time;
        } else {
            break;
        }
        time++;
    }

    int* result = (int*)malloc(sizeof(int) * 3);
    result[0] = time;
    result[1] = memory1;
    result[2] = memory2;
    *returnSize = 3;

    return result;
}