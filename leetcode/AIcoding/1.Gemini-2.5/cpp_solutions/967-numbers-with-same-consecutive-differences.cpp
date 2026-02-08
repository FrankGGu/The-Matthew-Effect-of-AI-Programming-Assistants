#include <vector>

class Solution {
public:
    std::vector<int> numsSameConsecDiff(int n, int k) {
        std::vector<int> result;

        for (int i = 1; i <= 9; ++i) {
            dfs(i, n - 1, k, result);
        }

        return result;
    }

private:
    void dfs(int current_num, int remaining_digits, int k, std::vector<int>& result) {
        if (remaining_digits == 0) {
            result.push_back(current_num);
            return;
        }

        int last_digit = current_num % 10;

        int next_digit_plus_k = last_digit + k;
        if (next_digit_plus_k >= 0 && next_digit_plus_k <= 9) {
            dfs(current_num * 10 + next_digit_plus_k, remaining_digits - 1, k, result);
        }

        if (k != 0) {
            int next_digit_minus_k = last_digit - k;
            if (next_digit_minus_k >= 0 && next_digit_minus_k <= 9) {
                dfs(current_num * 10 + next_digit_minus_k, remaining_digits - 1, k, result);
            }
        }
    }
};