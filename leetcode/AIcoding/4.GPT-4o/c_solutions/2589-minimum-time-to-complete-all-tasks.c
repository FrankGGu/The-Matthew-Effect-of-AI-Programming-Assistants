int minimumTime(int* tasks, int tasksSize, int space) {
    long long time = 0;
    int nextAvailableTime = 0;
    for (int i = 0; i < tasksSize; i++) {
        if (time < nextAvailableTime) {
            time = nextAvailableTime;
        }
        time += tasks[i];
        nextAvailableTime = time + space + 1;
    }
    return (int)time;
}