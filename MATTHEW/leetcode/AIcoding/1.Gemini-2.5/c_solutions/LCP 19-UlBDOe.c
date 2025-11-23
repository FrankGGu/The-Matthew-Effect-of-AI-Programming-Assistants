#include <string.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int minimumOperations(char * leaves){
    int n = strlen(leaves);

    const int INF = n + 1; 

    int dp0, dp1, dp2;

    dp0 = (leaves[0] == 'y' ? 1 : 0);
    dp1 = INF; 
    dp2 = INF; 

    for (int i = 1; i < n; i++) {
        int cost_r = (leaves[i] == 'y' ? 1 : 0);
        int cost_y = (leaves[i] == 'r' ? 1 : 0);

        int new_dp0, new_dp1, new_dp2;

        new_dp0 = dp0 + cost_r;
        new_dp1 = min(dp0, dp1) + cost_y;
        new_dp2 = min(dp1, dp2) + cost_r;

        dp0 = new_dp0;
        dp1 = new_dp1;
        dp2 = new_dp2;
    }

    return dp2;
}