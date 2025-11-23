class Solution {
public:
    long long maximumSubsequenceCount(string text, string pattern) {
        long long count = 0;
        long long countA = 0, countB = 0;

        for (char c : text) {
            if (c == pattern[1]) countB++;
        }

        for (char c : text) {
            if (c == pattern[0]) {
                countA++;
            } else if (c == pattern[1]) {
                count += countA;
            }
        }

        return count + (pattern[0] == pattern[1] ? countA * (countA + 1) / 2 : countB);
    }
};