int maxTasks(int* tasks, int tasksSize, int maxTime) {
    int count = 0;
    int totalTime = 0;

    for (int i = 0; i < tasksSize; i++) {
        totalTime += tasks[i];
        if (totalTime > maxTime) {
            break;
        }
        count++;
    }

    return count;
}