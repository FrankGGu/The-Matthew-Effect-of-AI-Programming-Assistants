int minimumEnergy(int** tasks, int tasksSize, int* tasksColSize) {
    int totalEnergy = 0, minEnergy = 0;
    for (int i = 0; i < tasksSize; i++) {
        totalEnergy += tasks[i][1];
        minEnergy = (minEnergy < tasks[i][0] - tasks[i][1]) ? tasks[i][0] - tasks[i][1] : minEnergy;
    }
    return totalEnergy + (minEnergy > 0 ? minEnergy : 0);
}