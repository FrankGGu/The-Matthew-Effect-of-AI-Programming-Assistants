#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countUnhappyFriends(int n, int** preferences, int* preferencesSize, int** pairs, int pairsSize) {
    int* rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        rank[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            rank[i][j] = -1;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            rank[i][preferences[i][j]] = j;
        }
    }

    int* pairMap = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < pairsSize; i++) {
        pairMap[pairs[i][0]] = pairs[i][1];
        pairMap[pairs[i][1]] = pairs[i][0];
    }

    int unhappyCount = 0;

    for (int i = 0; i < n; i++) {
        int partner = pairMap[i];
        int rankOfPartner = rank[i][partner];

        int isUnhappy = 0;
        for (int j = 0; j < n; j++) {
            if (i == preferences[i][j]) continue;
            int friend = preferences[i][j];
            int rankOfFriend = rank[i][friend];
            int partnerOfFriend = pairMap[friend];
            int rankOfPartnerOfFriend = rank[friend][partnerOfFriend];

            if (rankOfFriend < rankOfPartner && rankOfFriend < rankOfPartnerOfFriend) {
                isUnhappy = 1;
                break;
            }
        }

        if (isUnhappy) {
            unhappyCount++;
        }
    }

    free(rank);
    free(pairMap);
    return unhappyCount;
}