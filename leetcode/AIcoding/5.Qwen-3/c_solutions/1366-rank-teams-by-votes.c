#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *name;
    int *votes;
} Team;

int compare(const void *a, const void *b) {
    Team *ta = (Team *)a;
    Team *tb = (Team *)b;
    for (int i = 0; i < 26; i++) {
        if (ta->votes[i] != tb->votes[i]) {
            return tb->votes[i] - ta->votes[i];
        }
    }
    return strcmp(ta->name, tb->name);
}

char **rankTeams(char ***votes, int votesSize, int *votesColSize, int returnSize) {
    int count[26] = {0};
    for (int i = 0; i < votesSize; i++) {
        for (int j = 0; j < votesColSize[i]; j++) {
            count[votes[i][j] - 'A']++;
        }
    }

    Team *teams = (Team *)malloc(26 * sizeof(Team));
    for (int i = 0; i < 26; i++) {
        teams[i].name = (char *)malloc(2 * sizeof(char));
        sprintf(teams[i].name, "%c", 'A' + i);
        teams[i].votes = (int *)calloc(26, sizeof(int));
    }

    for (int i = 0; i < votesSize; i++) {
        for (int j = 0; j < votesColSize[i]; j++) {
            int idx = votes[i][j] - 'A';
            teams[idx].votes[j]++;
        }
    }

    qsort(teams, 26, sizeof(Team), compare);

    char **result = (char **)malloc(26 * sizeof(char *));
    int k = 0;
    for (int i = 0; i < 26; i++) {
        if (teams[i].votes[0] > 0) {
            result[k++] = teams[i].name;
        } else {
            free(teams[i].name);
            free(teams[i].votes);
        }
    }

    free(teams);
    returnSize[0] = k;
    return result;
}