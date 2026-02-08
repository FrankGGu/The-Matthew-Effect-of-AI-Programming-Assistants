#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int colorTheGrid(int m, int n) {
    if (m == 1 && n == 1) return 3;
    if (m == 1 && n == 2) return 6;
    if (m == 2 && n == 1) return 6;

    long long dp[n + 1][243];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < 243; j++) {
            dp[i][j] = 0;
        }
    }

    int valid_states[243] = {0};
    int num_valid_states = 0;

    void generate_states(int index, int current_state, int arr[]) {
        if (index == m) {
            valid_states[num_valid_states] = current_state;
            num_valid_states++;
            return;
        }
        for (int color = 0; color < 3; color++) {
            arr[index] = color;
            generate_states(index + 1, current_state * 3 + color, arr);
        }
    }

    int arr[m];
    generate_states(0, 0, arr);

    int valid_indices[243] = {0};
    int num_indices = 0;
    for (int i = 0; i < num_valid_states; i++) {
        int state = valid_states[i];
        int temp = state;
        int colors[m];
        for (int j = m - 1; j >= 0; j--) {
            colors[j] = temp % 3;
            temp /= 3;
        }

        int valid = 1;
        for (int j = 0; j < m - 1; j++) {
            if (colors[j] == colors[j + 1]) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            valid_indices[num_indices++] = state;
            dp[1][state] = 1;
        }
    }

    for (int i = 2; i <= n; i++) {
        for (int j = 0; j < num_indices; j++) {
            int state1 = valid_indices[j];
            int temp1 = state1;
            int colors1[m];
            for (int k = m - 1; k >= 0; k--) {
                colors1[k] = temp1 % 3;
                temp1 /= 3;
            }

            for (int l = 0; l < num_indices; l++) {
                int state2 = valid_indices[l];
                int temp2 = state2;
                int colors2[m];
                for (int k = m - 1; k >= 0; k--) {
                    colors2[k] = temp2 % 3;
                    temp2 /= 3;
                }

                int valid = 1;
                for (int k = 0; k < m; k++) {
                    if (colors1[k] == colors2[k]) {
                        valid = 0;
                        break;
                    }
                }
                if (valid) {
                    dp[i][state2] = (dp[i][state2] + dp[i - 1][state1]) % MOD;
                }
            }
        }
    }

    long long total = 0;
    for (int i = 0; i < num_indices; i++) {
        total = (total + dp[n][valid_indices[i]]) % MOD;
    }

    return (int)total;
}