int minimumRounds(int* tasks, int tasksSize) {
    int count[100001] = {0};
    for (int i = 0; i < tasksSize; i++) {
        count[tasks[i]]++;
    }

    int rounds = 0;
    for (int i = 0; i < 100001; i++) {
        if (count[i] > 0) {
            if (count[i] == 1) return -1;
            rounds += (count[i] + 2) / 3;
        }
    }

    return rounds;
}