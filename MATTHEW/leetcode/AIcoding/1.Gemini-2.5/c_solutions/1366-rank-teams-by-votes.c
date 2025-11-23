#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int g_counts_data[26][26];
int g_numTeams_val;

int compareTeams(const void* a, const void* b) {
    char team1 = *(char*)a;
    char team2 = *(char*)b;

    int idx1 = team1 - 'A';
    int idx2 = team2 - 'A';

    for (int i = 0; i < g_numTeams_val; ++i) {
        if (g_counts_data[idx1][i] != g_counts_data[idx2][i]) {
            return g_counts_data[idx2][i] - g_counts_data[idx1][i];
        }
    }

    return team1 - team2;
}

char* rankTeams(char** votes, int votesSize, int* votesColSize) {
    if (votesSize == 0) {
        char* result = (char*)malloc(sizeof(char));
        result[0] = '\0';
        return result;
    }

    memset(g_counts_data, 0, sizeof(g_counts_data));

    g_numTeams_val = strlen(votes[0]);

    for (int i = 0; i < votesSize; ++i) {
        for (int j = 0; j < g_numTeams_val; ++j) {
            char teamChar = votes[i][j];
            int teamIdx = teamChar - 'A';
            g_counts_data[teamIdx][j]++;
        }
    }

    char* teams = (char*)malloc((g_numTeams_val + 1) * sizeof(char));
    strncpy(teams, votes[0], g_numTeams_val);
    teams[g_numTeams_val] = '\0';

    qsort(teams, g_numTeams_val, sizeof(char), compareTeams);

    return teams;
}