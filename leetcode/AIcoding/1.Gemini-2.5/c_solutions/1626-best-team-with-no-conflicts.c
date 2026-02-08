#include <stdlib.h> // For malloc, free, qsort

typedef struct {
    int age;
    int score;
} Player;

int comparePlayers(const void* a, const void* b) {
    Player* p1 = (Player*)a;
    Player* p2 = (Player*)b;

    if (p1->age != p2->age) {
        return p1->age - p2->age;
    }
    return p1->score - p2->score;
}

long long max(long long a, long long b) {
    return (a > b) ? a : b;
}

int bestTeamWithNoConflicts(int* scores, int scoresSize, int* ages, int agesSize) {
    int n = scoresSize;
    Player* players = (Player*)malloc(n * sizeof(Player));

    for (int i = 0; i < n; i++) {
        players[i].age = ages[i];
        players[i].score = scores[i];
    }

    qsort(players, n, sizeof(Player), comparePlayers);

    long long* dp = (long long*)malloc(n * sizeof(long long));
    long long max_total_score = 0;

    for (int i = 0; i < n; i++) {
        dp[i] = players[i].score; // Base case: a team with only the current player
        for (int j = 0; j < i; j++) {
            // If players[j] can be part of a team ending with players[i]
            // Due to sorting (age asc, score asc), players[j].age <= players[i].age is guaranteed.
            // The only condition to check is that if players[i] has a higher score than players[j],
            // then players[i] must have an age greater than or equal to players[j]'s age.
            // This is satisfied if players[j].score <= players[i].score.
            if (players[j].score <= players[i].score) {
                dp[i] = max(dp[i], (long long)players[i].score + dp[j]);
            }
        }
        max_total_score = max(max_total_score, dp[i]);
    }

    free(players);
    free(dp);

    return (int)max_total_score;
}