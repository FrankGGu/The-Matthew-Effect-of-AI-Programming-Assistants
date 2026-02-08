class Solution {
public:
    void backtrack(int start, int k, int n, std::vector<int>& current_combination, std::vector<std::vector<int>>& result) {
        if (current_combination.size() == k) {
            result.push_back(current_combination);
            return;
        }

        for (int i = start; i <= n - (k - current_combination.size()) + 1; ++i) {
            current_combination.push_back(i);
            backtrack(i + 1, k, n, current_combination, result);
            current_combination.pop_back();
        }
    }

    std::vector<std::vector<int>> combine(int n, int k) {
        std::vector<std::vector<int>> result;
        std::vector<int> current_combination;
        backtrack(1, k, n, current_combination, result);
        return result;
    }
};