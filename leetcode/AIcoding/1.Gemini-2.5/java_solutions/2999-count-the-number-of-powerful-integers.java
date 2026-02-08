class Solution {
    private String S_val;
    private int LIMIT_val;
    private String NUM_STR;
    private int N_len; // length of NUM_STR
    private int M_len; // length of S_val
    private Long[][][][] memo;

    public long countPowerfulIntegers(long start, long finish, int limit, String s) {
        this.S_val = s;
        this.LIMIT_val = limit;
        this.M_len = s.length();

        long ansFinish = calculateCount(finish);
        long ansStartMinus1 = calculateCount(start - 1);

        return ansFinish - ansStartMinus1;
    }

    private long calculateCount(long n) {
        if (n < 0) {
            return 0;
        }

        this.NUM_STR = String.valueOf(n);
        this.N_len = NUM_STR.length();

        // A powerful integer must have a positive prefix.
        // This means the total length of the powerful integer must be strictly greater than M_len.
        // If N_len <= M_len, no powerful integer <= n can be formed.
        if (N_len <= M_len) {
            return 0;
        }

        long totalCount = 0;

        // Case 1: Count powerful integers with length L, where M_len < L < N_len.
        // For these, the prefix P has length P_len = L - M_len. P_len >= 1.
        // The first digit of P can be 1 to LIMIT_val.
        // The remaining P_len - 1 digits can be 0 to LIMIT_val.
        for (int L = M_len + 1; L < N_len; L++) {
            int P_len = L - M_len;
            // Number of choices for the first digit of P (1 to LIMIT_val)
            // Number of choices for subsequent P_len - 1 digits (0 to LIMIT_val)
            long numP = (long) LIMIT_val * (long) Math.pow(LIMIT_val + 1, P_len - 1);
            totalCount += numP;
        }

        // Case 2: Count powerful integers with length N_len, up to NUM_STR.
        // The prefix P has length P_len = N_len - M_len. P_len >= 1 here.
        memo = new Long[N_len][2][2][2]; // idx, tight, is_leading_zero, is_prefix_started
        totalCount += dfs(0, true, true, false);

        return totalCount;
    }

    // idx: current digit position in the number being built (0 to N_len-1)
    // tight: true if we are restricted by NUM_STR[idx]
    // is_leading_zero: true if we are currently placing leading zeros for the prefix P
    // is_prefix_started: true if we have placed at least one non-zero digit for P
    private long dfs(int idx, boolean tight, boolean is_leading_zero, boolean is_prefix_started) {
        if (idx == N_len) {
            // A valid number is formed only if the prefix P was positive.
            return is_prefix_started ? 1L : 0L;
        }

        int tight_int = tight ? 1 : 0;
        int is_leading_zero_int = is_leading_zero ? 1 : 0;
        int is_prefix_started_int = is_prefix_started ? 1 : 0;

        if (memo[idx][tight_int][is_leading_zero_int][is_prefix_started_int] != null) {
            return memo[idx][tight_int][is_leading_zero_int][is_prefix_started_int];
        }

        long res = 0L;
        int upperBoundDigit = tight ? (NUM_STR.charAt(idx) - '0') : 9;

        if (idx < N_len - M_len) { // We are in the prefix P part
            for (int digit = 0; digit <= upperBoundDigit; digit++) {
                if (is_leading_zero) {
                    if (digit == 0) {
                        // Still placing leading zeros (for P, which must be positive eventually)
                        res += dfs(idx + 1, tight && (digit == upperBoundDigit), true, false);
                    } else { // digit > 0, P starts here
                        if (digit > LIMIT_val) {
                            continue; // Digit exceeds limit
                        }
                        res += dfs(idx + 1, tight && (digit == upperBoundDigit), false, true);
                    }
                } else { // P has already started
                    if (digit > LIMIT_val) {
                        continue; // Digit exceeds limit
                    }
                    res += dfs(idx + 1, tight && (digit == upperBoundDigit), false, true);
                }
            }
        } else { // We are in the suffix S part (idx >= N_len - M_len)
            int s_char_idx = idx - (N_len - M_len); // Index in S_val string
            int expected_s_digit = S_val.charAt(s_char_idx) - '0';

            // We must place the expected digit from S_val.
            // If the expected digit exceeds the upper bound (due to tight constraint),
            // then no valid number can be formed through this path.
            if (expected_s_digit <= upperBoundDigit) {
                res += dfs(idx + 1, tight && (expected_s_digit == upperBoundDigit), false, is_prefix_started);
            }
            // If expected_s_digit > upperBoundDigit, res remains 0, which is correct.
        }

        memo[idx][tight_int][is_leading_zero_int][is_prefix_started_int] = res;
        return res;
    }
}