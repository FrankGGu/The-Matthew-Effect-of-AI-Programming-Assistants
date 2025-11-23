#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    int maxConsecutiveAnswers(std::string answerKey, int k) {
        return std::max(solve(answerKey, k, 'T'), solve(answerKey, k, 'F'));
    }

private:
    int solve(const std::string& s, int k, char target_char) {
        int n = s.length();
        int left = 0;
        int max_len = 0;
        int other_char_count = 0;

        for (int right = 0; right < n; ++right) {
            if (s[right] != target_char) {
                other_char_count++;
            }
            while (other_char_count > k) {
                if (s[left] != target_char) {
                    other_char_count--;
                }
                left++;
            }
            max_len = std::max(max_len, right - left + 1);
        }
        return max_len;
    }
};