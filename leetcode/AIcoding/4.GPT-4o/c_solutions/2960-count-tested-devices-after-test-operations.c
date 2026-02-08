int countTestedDevices(int* devices, int devicesSize, int* operations, int operationsSize) {
    int tested[1001] = {0};
    for (int i = 0; i < operationsSize; i++) {
        tested[operations[i]] = 1;
    }
    int count = 0;
    for (int i = 0; i < devicesSize; i++) {
        if (tested[devices[i]]) {
            count++;
        }
    }
    return count;
}