#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int unhappyFriends(int n, int** preferences, int preferencesSize, int* preferencesColSize, int** pairs, int pairsSize, int* pairsColSize) {
    int unhappy_count = 0;
    int pref[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            pref[i][preferences[i][j]] = j;
        }
    }

    for (int i = 0; i < pairsSize; i++) {
        int x = pairs[i][0];
        int y = pairs[i][1];

        for (int j = 0; j < pairsSize; j++) {
            if (i == j) continue;
            int u = pairs[j][0];
            int v = pairs[j][1];

            if (pref[x][u] < pref[x][y]) {
                if (pref[u][x] < pref[u][v]) {
                    unhappy_count++;
                    break;
                }
            }

            if (pref[x][v] < pref[x][y]) {
                if (pref[v][x] < pref[v][u]) {
                    unhappy_count++;
                    break;
                }
            }
        }
    }

    for (int i = 0; i < pairsSize; i++) {
        int x = pairs[i][0];
        int y = pairs[i][1];

        for (int j = 0; j < pairsSize; j++) {
            if (i == j) continue;
            int u = pairs[j][0];
            int v = pairs[j][1];

            if (pref[y][u] < pref[y][x]) {
                if (pref[u][y] < pref[u][v]) {
                    unhappy_count++;
                    break;
                }
            }

            if (pref[y][v] < pref[y][x]) {
                if (pref[v][y] < pref[v][u]) {
                    unhappy_count++;
                    break;
                }
            }
        }
    }

    int result = 0;
    int unhappy[n];
    for(int i = 0; i < n; i++){
        unhappy[i] = 0;
    }

    for (int i = 0; i < pairsSize; i++) {
        int x = pairs[i][0];
        int y = pairs[i][1];

        for (int j = 0; j < pairsSize; j++) {
            if (i == j) continue;
            int u = pairs[j][0];
            int v = pairs[j][1];

            if (pref[x][u] < pref[x][y]) {
                if (pref[u][x] < pref[u][v]) {
                    unhappy[x] = 1;
                }
            }

            if (pref[x][v] < pref[x][y]) {
                if (pref[v][x] < pref[v][u]) {
                    unhappy[x] = 1;
                }
            }

            if (pref[y][u] < pref[y][x]) {
                if (pref[u][y] < pref[u][v]) {
                    unhappy[y] = 1;
                }
            }

            if (pref[y][v] < pref[y][x]) {
                if (pref[v][y] < pref[v][u]) {
                    unhappy[y] = 1;
                }
            }
        }
    }

    for(int i = 0; i < n; i++){
        result += unhappy[i];
    }

    return result;
}