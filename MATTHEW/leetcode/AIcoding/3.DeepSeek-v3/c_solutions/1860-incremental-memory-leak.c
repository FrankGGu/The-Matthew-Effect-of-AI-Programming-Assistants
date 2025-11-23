int* memLeak(int memory1, int memory2, int* returnSize) {
    int* result = (int*)malloc(3 * sizeof(int));
    *returnSize = 3;

    int time = 1;
    while (1) {
        if (memory1 >= memory2) {
            if (memory1 < time) {
                break;
            }
            memory1 -= time;
        } else {
            if (memory2 < time) {
                break;
            }
            memory2 -= time;
        }
        time++;
    }

    result[0] = time;
    result[1] = memory1;
    result[2] = memory2;
    return result;
}