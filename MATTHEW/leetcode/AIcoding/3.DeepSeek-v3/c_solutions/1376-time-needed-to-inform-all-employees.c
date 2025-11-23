int numOfMinutes(int n, int headID, int* manager, int managerSize, int* informTime, int informTimeSize) {
    int *time = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) time[i] = -1;
    time[headID] = 0;

    int maxTime = 0;
    for (int i = 0; i < n; i++) {
        if (time[i] == -1) {
            int current = i;
            int totalTime = 0;
            while (time[current] == -1) {
                totalTime += informTime[manager[current]];
                current = manager[current];
            }
            totalTime += time[current];

            current = i;
            while (time[current] == -1) {
                time[current] = totalTime;
                totalTime -= informTime[manager[current]];
                current = manager[current];
            }
        }
        if (time[i] > maxTime) maxTime = time[i];
    }

    free(time);
    return maxTime;
}