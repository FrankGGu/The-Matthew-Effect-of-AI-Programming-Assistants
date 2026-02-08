class Solution {
public:
    char kthCharacter(int n, int m, long long k) {
        long long idx = k - 1;
        char current_char = 'a';

        for (int i = n; i > 0; --i) {
            long long sub_len = 1;
            for (int j = 0; j < i - 1; ++j) {
                if (k / (m + 2) < sub_len) {
                    sub_len = k + 1;
                    break;
                }
                sub_len *= (m + 2);
            }

            char next_first, next_middle, next_last;
            if (current_char == 'a') {
                next_first = 'a';
                next_middle = 'b';
                next_last = 'c';
            } else if (current_char == 'b') {
                next_first = 'b';
                next_middle = 'c';
                next_last = 'a';
            } else {
                next_first = 'c';
                next_middle = 'a';
                next_last = 'b';
            }

            if (idx < sub_len) {
                current_char = next_first;
            } else {
                idx -= sub_len;
                if (m == 0) {
                    current_char = next_last;
                } else {
                    if (idx / m < sub_len) {
                        current_char = next_middle;
                        idx %= sub_len;
                    } else {
                        idx -= (long long)m * sub_len;
                        current_char = next_last;
                    }
                }
            }
        }

        return current_char;
    }
};