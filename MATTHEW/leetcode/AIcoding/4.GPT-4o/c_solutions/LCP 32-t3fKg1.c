int minTimeToCompleteTasks(int* tasks, int tasksSize, int timeLimit) {
    int totalTime = 0;
    for (int i = 0; i < tasksSize; i++) {
        totalTime += tasks[i];
    }
    return (totalTime + timeLimit - 1) / timeLimit;
}