#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(char *)a - *(char *)b;
}

char * rankTeams(char ** votes, int votesSize) {
    int numTeams = strlen(votes[0]);
    int *rank = (int *)calloc(numTeams, sizeof(int));
    char *result = (char *)malloc((numTeams + 1) * sizeof(char));

    for (int i = 0; i < votesSize; i++) {
        for (int j = 0; j < numTeams; j++) {
            rank[votes[i][j] - 'A'] += j;
        }
    }

    char **teams = (char **)malloc(numTeams * sizeof(char *));
    for (int i = 0; i < numTeams; i++) {
        teams[i] = (char *)malloc(2 * sizeof(char));
        teams[i][0] = 'A' + i;
        teams[i][1] = '\0';
    }

    qsort(teams, numTeams, sizeof(char *), compare);

    for (int i = 0; i < numTeams; i++) {
        result[i] = teams[i][0];
        free(teams[i]);
    }
    result[numTeams] = '\0';

    free(teams);
    free(rank);
    return result;
}