#include <limits.h>
#include <stdlib.h>
#include <math.h>

int* g_cookies;
int g_n;
int g_k;
int g_minUnfairness;

void dfs(int cookieIndex, int* childrenSums) {
    int currentMaxOfChildren = 0;
    for (int i = 0; i < g_k; i++) {
        if (childrenSums[i] > currentMaxOfChildren) {
            currentMaxOfChildren = childrenSums[i];
        }
    }
    if (currentMaxOfChildren >= g_minUnfairness) {
        return;
    }

    if (cookieIndex == g_n) {
        int maxCurrentSum = 0;
        for (int i = 0; i < g_k; i++) {
            if (childrenSums[i] > maxCurrentSum) {
                maxCurrentSum = childrenSums[i];
            }
        }
        if (maxCurrentSum < g_minUnfairness) {
            g_minUnfairness = maxCurrentSum;
        }
        return;
    }

    for (int i = 0; i < g_k; i++) {
        childrenSums[i] += g_cookies[cookieIndex];

        dfs(cookieIndex + 1, childrenSums);

        childrenSums[i] -= g_cookies[cookieIndex];

        if (childrenSums[i] == 0) {
            break;
        }
    }
}

int distributeCookies(int* cookies, int cookiesSize, int k) {
    g_cookies = cookies;
    g_n = cookiesSize;
    g_k = k;
    g_minUnfairness = INT_MAX;

    int* childrenSums = (int*)calloc(k, sizeof(int));

    dfs(0, childrenSums);

    free(childrenSums);
    return g_minUnfairness;
}