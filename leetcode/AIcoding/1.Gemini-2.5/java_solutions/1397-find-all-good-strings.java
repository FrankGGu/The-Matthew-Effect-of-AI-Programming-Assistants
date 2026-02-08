class Solution {
    int MOD = 1_000_000_007;
    int N;
    String S1, S2, EVIL;
    int EVIL_LEN;
    int[] LPS;
    int[][] KMP_NEXT_STATE;
    Integer[][][][] MEMO;

    public int findGoodStrings(int n, String s1, String s2, String evil) {
        N = n;
        S1 = s1;
        S2 = s2;
        EVIL = evil;
        EVIL_LEN = evil.length();

        precomputeKMP();

        MEMO = new Integer[N][EVIL_LEN + 1][2][2];
        return solve(0, 0, true, true);
    }

    private void precomputeKMP() {
        LPS = new int[EVIL_LEN];
        int length = 0;
        int i = 1;
        while (i < EVIL_LEN) {
            if (EVIL.charAt(i) == EVIL.charAt(length)) {
                length++;
                LPS[i] = length;
                i++;
            } else {
                if (length != 0) {
                    length = LPS[length - 1];
                } else {
                    LPS[i] = 0;
                    i++;
                }
            }
        }

        KMP_NEXT_STATE = new int[EVIL_LEN + 1][26];
        for (int j = 0; j <= EVIL_LEN; j++) {
            for (int char_code = 0; char_code < 26; char_code++) {
                char c = (char)('a' + char_code);
                if (j < EVIL_LEN && EVIL.charAt(j) == c) {
                    KMP_NEXT_STATE[j][char_code] = j + 1;
                } else {
                    if (j == 0) {
                        KMP_NEXT_STATE[j][char_code] = 0;
                    } else {
                        KMP_NEXT_STATE[j][char_code] = KMP_NEXT_STATE[LPS[j - 1]][char_code];
                    }
                }
            }
        }
    }

    private int solve(int idx, int evil_kmp_state, boolean tight_low, boolean tight_high) {
        if (evil_kmp_state == EVIL_LEN) {
            return 0;
        }
        if (idx == N) {
            return 1;
        }

        if (MEMO[idx][evil_kmp_state][tight_low ? 1 : 0][tight_high ? 1 : 0] != null) {
            return MEMO[idx][evil_kmp_state][tight_low ? 1 : 0][tight_high ? 1 : 0];
        }

        long ans = 0;
        char lower_bound_char = tight_low ? S1.charAt(idx) : 'a';
        char upper_bound_char = tight_high ? S2.charAt(idx) : 'z';

        for (char ch = lower_bound_char; ch <= upper_bound_char; ch++) {
            int new_evil_kmp_state = KMP_NEXT_STATE[evil_kmp_state][ch - 'a'];

            boolean new_tight_low = tight_low && (ch == lower_bound_char);
            boolean new_tight_high = tight_high && (ch == upper_bound_char);

            ans = (ans + solve(idx + 1, new_evil_kmp_state, new_tight_low, new_tight_high)) % MOD;
        }

        return MEMO[idx][evil_kmp_state][tight_low ? 1 : 0][tight_high ? 1 : 0] = (int) ans;
    }
}