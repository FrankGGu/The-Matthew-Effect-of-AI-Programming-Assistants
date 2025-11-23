int busyStudent(int* startTime, int startTimeSize, int* endTime, int endTimeSize, int queryTime) {
    int count = 0;
    for (int i = 0; i < startTimeSize; i++) {
        if (startTime[i] <= queryTime && endTime[i] >= queryTime) {
            count++;
        }
    }
    return count;
}