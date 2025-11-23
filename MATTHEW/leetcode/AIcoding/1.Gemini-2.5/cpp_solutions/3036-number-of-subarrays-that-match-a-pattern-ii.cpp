#include <vector>

class Solution {
public:
    int countMatchingSubarrays(std::vector<int>& nums, std::vector<int>& pattern) {
        int n_nums = nums.size();
        if (n_nums <= 1) {
            return 0;
        }

        std::vector<int> text(n_nums - 1);
        for (int i = 0; i < n_nums - 1; ++i) {
            if (nums[i+1] > nums[i]) {
                text[i] = 1;
            } else if (nums[i+1] < nums[i]) {
                text[i] = -1;
            } else {
                text[i] = 0;
            }
        }

        int N = text.size();
        int M = pattern.size();

        if (M == 0) {
            return 0;
        }
        if (N < M) {
            return 0;
        }

        std::vector<int> lps(M, 0);
        int length = 0;
        int i = 1;
        while (i < M) {
            if (pattern[i] == pattern[length]) {
                length++;
                lps[i] = length;
                i++;
            } else {
                if (length != 0) {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }

        int count = 0;
        int text_idx = 0;
        int pattern_idx = 0;

        while (text_idx < N) {
            if (pattern[pattern_idx] == text[text_idx]) {
                text_idx++;
                pattern_idx++;
            }

            if (pattern_idx == M) {
                count++;
                pattern_idx = lps[pattern_idx - 1];
            } else if (text_idx < N && pattern[pattern_idx] != text[text_idx]) {
                if (pattern_idx != 0) {
                    pattern_idx = lps[pattern_idx - 1];
                } else {
                    text_idx++;
                }
            }
        }

        return count;
    }
};