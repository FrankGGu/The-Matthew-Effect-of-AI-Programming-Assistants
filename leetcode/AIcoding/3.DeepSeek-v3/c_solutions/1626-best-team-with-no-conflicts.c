typedef struct {
    int score;
    int age;
} Player;

int cmp(const void* a, const void* b) {
    Player* p1 = (Player*)a;
    Player* p2 = (Player*)b;
    if (p1->age == p2->age) {
        return p1->score - p2->score;
    }
    return p1->age - p2->age;
}

int bestTeamScore(int* scores, int scoresSize, int* ages, int agesSize) {
    Player players[scoresSize];
    for (int i = 0; i < scoresSize; i++) {
        players[i].score = scores[i];
        players[i].age = ages[i];
    }

    qsort(players, scoresSize, sizeof(Player), cmp);

    int dp[scoresSize];
    int maxScore = 0;

    for (int i = 0; i < scoresSize; i++) {
        dp[i] = players[i].score;
        for (int j = 0; j < i; j++) {
            if (players[j].score <= players[i].score) {
                if (dp[j] + players[i].score > dp[i]) {
                    dp[i] = dp[j] + players[i].score;
                }
            }
        }
        if (dp[i] > maxScore) {
            maxScore = dp[i];
        }
    }

    return maxScore;
}