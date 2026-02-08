int maximumPoints(int** enemy, int enemySize, int* enemyColSize, int* energy, int energySize) {
    long long total = 0;
    for (int i = 0; i < energySize; i++) {
        total += energy[i];
    }

    int min_enemy = enemy[0][0];
    for (int i = 0; i < enemySize; i++) {
        if (enemy[i][0] < min_enemy) {
            min_enemy = enemy[i][0];
        }
    }

    if (total < min_enemy) {
        return 0;
    }

    int points = 0;
    for (int i = 0; i < enemySize; i++) {
        if (total >= enemy[i][0]) {
            points += enemy[i][1];
        }
    }

    return points;
}