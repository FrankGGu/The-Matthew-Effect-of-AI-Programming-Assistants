class Solution {
    public int countSpecialSubsequences(String s) {
        long count_a = 0;
        long count_ab = 0;
        long count_abc = 0;
        long MOD = 1_000_000_007;

        for (char ch : s.toCharArray()) {
            if (ch == 'a') {
                // When 'a' is encountered:
                // 1. We can start a new 'a' subsequence (1 way).
                // 2. For each existing 'a' subsequence, we can either include this 'a' or not.
                //    This effectively doubles the number of existing 'a' subsequences.
                // So, new_count_a = (old_count_a + old_count_a + 1)
                count_a = (2 * count_a + 1) % MOD;
            } else if (ch == 'b') {
                // When 'b' is encountered:
                // 1. For each existing 'ab' subsequence, we can either include this 'b' or not.
                //    This doubles the number of existing 'ab' subsequences.
                // 2. We can form new 'ab' subsequences by appending this 'b' to any existing 'a' subsequence.
                //    There are `count_a` such ways.
                // So, new_count_ab = (old_count_ab + old_count_ab + count_a)
                count_ab = (2 * count_ab + count_a) % MOD;
            } else if (ch == 'c') {
                // When 'c' is encountered:
                // 1. For each existing 'abc' subsequence, we can either include this 'c' or not.
                //    This doubles the number of existing 'abc' subsequences.
                // 2. We can form new 'abc' subsequences by appending this 'c' to any existing 'ab' subsequence.
                //    There are `count_ab` such ways.
                // So, new_count_abc = (old_count_abc + old_count_abc + count_ab)
                count_abc = (2 * count_abc + count_ab) % MOD;
            }
        }

        return (int) count_abc;
    }
}