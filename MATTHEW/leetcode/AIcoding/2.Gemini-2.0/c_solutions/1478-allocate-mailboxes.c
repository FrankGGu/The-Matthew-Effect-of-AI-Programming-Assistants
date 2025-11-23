#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDistance(int* houses, int housesSize, int mailbox) {
    int distance = 0;
    for (int i = 0; i < housesSize; i++) {
        distance += abs(houses[i] - mailbox);
    }
    return distance;
}

int minTotalDistance(int* houses, int housesSize) {
    if (housesSize == 0) {
        return 0;
    }

    qsort(houses, housesSize, sizeof(int), [](const void *a, const void *b) {
        return (*(int*)a - *(int*)b);
    });

    int median = houses[housesSize / 2];
    return minDistance(houses, housesSize, median);
}

int solve(int* houses, int housesSize, int k, int** cost, int** dp) {
    if (k == 1) {
        return cost[0][housesSize - 1];
    }
    if (dp[housesSize][k] != -1) {
        return dp[housesSize][k];
    }

    int min_cost = INT_MAX;
    for (int i = 1; i < housesSize; i++) {
        int current_cost = solve(houses, i, k - 1, cost, dp) + cost[i][housesSize - 1];
        if (current_cost < min_cost) {
            min_cost = current_cost;
        }
    }

    dp[housesSize][k] = min_cost;
    return min_cost;
}

int minDistanceToHouse(int* houses, int housesSize, int left, int right, int** cost) {

    qsort(houses + left, right - left + 1, sizeof(int), [](const void *a, const void *b) {
        return (*(int*)a - *(int*)b);
    });

    int median = houses[left + (right - left) / 2];
    int distance = 0;
    for (int i = left; i <= right; i++) {
        distance += abs(houses[i] - median);
    }
    return distance;
}

int minDistance(int* houses, int housesSize, int k) {
    qsort(houses, housesSize, sizeof(int), [](const void *a, const void *b) {
        return (*(int*)a - *(int*)b);
    });

    int **cost = (int**)malloc(housesSize * sizeof(int*));
    for (int i = 0; i < housesSize; i++) {
        cost[i] = (int*)malloc(housesSize * sizeof(int));
    }

    for (int i = 0; i < housesSize; i++) {
        for (int j = i; j < housesSize; j++) {
            int temp_houses[j - i + 1];
            for(int l=0; l<=j-i; l++){
                temp_houses[l] = houses[i+l];
            }

            qsort(temp_houses, j - i + 1, sizeof(int), [](const void *a, const void *b) {
                return (*(int*)a - *(int*)b);
            });

            int median = temp_houses[(j - i) / 2];
            int distance = 0;
            for(int l=0; l<=j-i; l++){
                distance += abs(temp_houses[l] - median);
            }
            cost[i][j] = distance;
        }
    }

    int **dp = (int**)malloc((housesSize + 1) * sizeof(int*));
    for (int i = 0; i <= housesSize; i++) {
        dp[i] = (int*)malloc((k + 1) * sizeof(int));
        for (int j = 0; j <= k; j++) {
            dp[i][j] = -1;
        }
    }

    int result = solve(houses, housesSize, k, cost, dp);

    for (int i = 0; i < housesSize; i++) {
        free(cost[i]);
    }
    free(cost);

    for (int i = 0; i <= housesSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}