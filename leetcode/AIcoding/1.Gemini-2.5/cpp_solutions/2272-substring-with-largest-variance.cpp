class Solution {
public:
    int largestVariance(std::string s) {
        int max_variance = 0;

        for (char char_a = 'a'; char_a <= 'z'; ++char_a) {
            for (char char_b = 'a'; char_b <= 'z'; ++char_b) {
                if (char_a == char_b) {
                    continue;
                }

                int current_diff = 0; // Tracks count(char_a) - count(char_b)
                // current_diff_with_b_seen tracks count(char_a) - count(char_b)
                // but ensures that at least one char_b has been encountered in the current segment.
                // It can be thought of as `current_diff` but allowing a reset to `current_diff - 1`
                // when char_b is encountered, effectively starting a new segment where this char_b is the first.
                int current_diff_with_b_seen = -1e9; // Represents negative infinity

                for (char c : s) {
                    if (c == char_a) {
                        current_diff++;
                        current_diff_with_b_seen++;
                    } else if (c == char_b) {
                        current_diff_with_b_seen = std::max(current_diff_with_b_seen, current_diff - 1);
                        current_diff--;
                    }

                    // Update max_variance.
                    // current_diff_with_b_seen ensures count(char_b) >= 1.
                    // If current_diff_with_b_seen >= 0, it means count(char_a) >= count(char_b) >= 1,
                    // so count(char_a) >= 1 is also satisfied.
                    // If current_diff_with_b_seen < 0, it means count(char_a) < count(char_b).
                    // This case will be handled when char_a and char_b are swapped in the outer loops.
                    max_variance = std::max(max_variance, current_diff_with_b_seen);

                    // Kadane's reset logic: If current_diff becomes negative, it's better to start a new subarray.
                    // If current_diff is reset, then current_diff_with_b_seen must also be reset
                    // to reflect that the previous char_b's are no longer part of the segment.
                    if (current_diff < 0) {
                        current_diff = 0;
                        current_diff_with_b_seen = -1e9; // Reset to negative infinity
                    }
                }
            }
        }
        return max_variance;
    }
};