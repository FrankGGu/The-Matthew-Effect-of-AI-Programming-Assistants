#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<std::vector<int>> combine(int n, int k) {
        std::vector<std::vector<int>> result;
        std::vector<int> current_combination;
        backtrack(1, n, k, current_combination, result);
        return result;
    }

private:
    void backtrack(int start, int n, int k, 
                   std::vector<int>& current_combination, 
                   std::vector<std::vector<int>>& result) {

        if (current_combination.size() == k) {
            result.push_back(current_combination);
            return;
        }

        // Optimization: if we don't have enough numbers left to pick to reach k, stop
        // k - current_combination.size() is the number of elements still needed
        // n - i + 1 is the number of elements available from 'i' to 'n'
        // We need: n - i + 1 >= k - current_combination.size()
        // So, i <= n - (k - current_combination.size()) + 1
        int remaining_needed = k - current_combination.size();
        for (int i = start; i <= n - remaining_needed + 1; ++i) {
            current_combination.push_back(i);
            backtrack(i + 1, n, k, current_combination, result);
            current_combination.pop_back(); // Backtrack
        }
    }
};