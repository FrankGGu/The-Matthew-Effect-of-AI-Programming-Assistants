#include <string>
#include <vector>
#include <algorithm>

class Solution {
private:
    std::vector<std::vector<std::vector<int>>> memo;
    const std::string* word_ptr;

    int calculate_distance(int char_idx1, int char_idx2) {
        if (char_idx1 == -1) {
            return 0;
        }

        int r1 = char_idx1 / 6;
        int c1 = char_idx1 % 6;
        int r2 = char_idx2 / 6;
        int c2 = char_idx2 % 6;

        return std::abs(r1 - r2) + std::abs(c1 - c2);
    }

    int solve(int idx, int f1_pos_idx, int f2_pos_idx) {
        if (idx == word_ptr->length()) {
            return 0;
        }

        int memo_f1_idx = (f1_pos_idx == -1) ? 26 : f1_pos_idx;
        int memo_f2_idx = (f2_pos_idx == -1) ? 26 : f2_pos_idx;

        if (memo[idx][memo_f1_idx][memo_f2_idx] != -1) {
            return memo[idx][memo_f1_idx][memo_f2_idx];
        }

        int target_char_idx = (*word_ptr)[idx] - 'A';

        int cost1 = calculate_distance(f1_pos_idx, target_char_idx);
        cost1 += solve(idx + 1, target_char_idx, f2_pos_idx);

        int cost2 = calculate_distance(f2_pos_idx, target_char_idx);
        cost2 += solve(idx + 1, f1_pos_idx, target_char_idx);

        return memo[idx][memo_f1_idx][memo_f2_idx] = std::min(cost1, cost2);
    }

public:
    int minimumDistance(std::string word) {
        word_ptr = &word;
        int N = word.length();

        memo.assign(N, std::vector<std::vector<int>>(27, std::vector<int>(27, -1)));

        return solve(0, -1, -1);
    }
};