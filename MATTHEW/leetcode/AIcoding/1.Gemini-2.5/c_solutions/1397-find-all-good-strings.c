#include <string.h>

#define MOD 1000000007

int N_LEN;
int M_LEN;

char S1_GLOBAL[505];
char S2_GLOBAL[505];
char EVIL_GLOBAL[55];

int lps[55];
int kmp_next[55][26];
int memo[505][55][2][2];

void compute_lps() {
    lps[0] = 0;
    int len = 0;
    for (int i = 1; i < M_LEN; i++) {
        while (len > 0 && EVIL_GLOBAL[i] != EVIL_GLOBAL[len]) {
            len = lps[len - 1];
        }
        if (EVIL_GLOBAL[i] == EVIL_GLOBAL[len]) {
            len++;
        }
        lps[i] = len;
    }
}

void precompute_kmp_transitions() {
    for (int j = 0; j < M_LEN; j++) {
        for (int c = 0; c < 26; c++) {
            int current_len = j;
            char char_to_append = 'a' + c;

            while (current_len > 0 && char_to_append != EVIL_GLOBAL[current_len]) {
                current_len = lps[current_len - 1];
            }
            if (char_to_append == EVIL_GLOBAL[current_len]) {
                current_len++;
            }
            kmp_next[j][c] = current_len;
        }
    }
}

int solve(int idx, int evil_match_len, int tight_s1, int tight_s2) {
    if (evil_match_len == M_LEN) {
        return 0;
    }
    if (idx == N_LEN) {
        return 1;
    }
    if (memo[idx][evil_match_len][tight_s1][tight_s2] != -1) {
        return memo[idx][evil_match_len][tight_s1][tight_s2];
    }

    long long ans = 0;

    char lower_bound_char = tight_s1 ? S1_GLOBAL[idx] : 'a';
    char upper_bound_char = tight_s2 ? S2_GLOBAL[idx] : 'z';

    for (char char_code = lower_bound_char; char_code <= upper_bound_char; char_code++) {
        int next_evil_match_len = kmp_next[evil_match_len][char_code - 'a'];

        int next_tight_s1 = tight_s1 && (char_code == S1_GLOBAL[idx]);
        int next_tight_s2 = tight_s2 && (char_code == S2_GLOBAL[idx]);

        ans = (ans + solve(idx + 1, next_evil_match_len, next_tight_s1, next_tight_s2)) % MOD;
    }

    return memo[idx][evil_match_len][tight_s1][tight_s2] = (int)ans;
}

int findGoodStrings(int n, char *s1, char *s2, char *evil) {
    N_LEN = n;
    strcpy(S1_GLOBAL, s1);
    strcpy(S2_GLOBAL, s2);
    strcpy(EVIL_GLOBAL, evil);
    M_LEN = strlen(evil);

    compute_lps();
    precompute_kmp_transitions();

    memset(memo, -1, sizeof(memo));

    return solve(0, 0, 1, 1);
}