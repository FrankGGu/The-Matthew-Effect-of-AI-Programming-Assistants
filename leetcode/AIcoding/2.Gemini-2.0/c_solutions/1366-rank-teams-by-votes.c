#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b, void *arg) {
    char team1 = *(char *)a;
    char team2 = *(char *)b;
    int *ranks = (int *)arg;
    int numTeams = ranks[0];
    int numVotes = ranks[1];
    int *votes = &ranks[2];

    for (int i = 0; i < numTeams; i++) {
        int rank1 = 0;
        int rank2 = 0;

        for (int j = 0; j < numVotes; j++) {
            char *vote = (char *)&votes[j * numTeams];
            for (int k = 0; k < numTeams; k++) {
                if (vote[k] == team1) {
                    rank1 = k + 1;
                }
                if (vote[k] == team2) {
                    rank2 = k + 1;
                }
            }
        }

        if (rank1 != 0 && rank2 != 0) {
            if (rank1 < rank2) {
                return -1;
            } else if (rank1 > rank2) {
                return 1;
            }
        } else if (rank1 != 0) {
            return -1;
        } else if (rank2 != 0) {
            return 1;
        }
    }
    return team1 - team2;
}

char *rankTeams(char **votes, int votesSize) {
    int numTeams = strlen(votes[0]);
    int *ranks = (int *)malloc((2 + votesSize * numTeams) * sizeof(int));
    ranks[0] = numTeams;
    ranks[1] = votesSize;
    for (int i = 0; i < votesSize; i++) {
        memcpy(&ranks[2 + i * numTeams], votes[i], numTeams);
    }

    char *teams = (char *)malloc((numTeams + 1) * sizeof(char));
    for (int i = 0; i < numTeams; i++) {
        teams[i] = votes[0][i];
    }
    teams[numTeams] = '\0';

    qsort_r(teams, numTeams, sizeof(char), compare, ranks);

    free(ranks);
    return teams;
}