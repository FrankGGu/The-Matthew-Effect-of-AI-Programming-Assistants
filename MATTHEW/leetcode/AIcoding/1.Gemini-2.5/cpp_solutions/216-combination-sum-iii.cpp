#include <vector>

class Solution {
public:
    std::vector<std::vector<int>> combinationSum3(int k, int n) {
        std::vector<std::vector<int>> result;
        std::vector<int> combination;
        findCombinations(k, n, 1, combination, result);
        return result;
    }

private:
    void findCombinations(int k, int n, int start, std::vector<int>& combination, std::vector<std::vector<int>>& result) {
        if (k == 0) {
            if (n == 0) {
                result.push_back(combination);
            }
            return;
        }

        if (n < 0) {
            return;
        }

        for (int i = start; i <= 9; ++i) {
            if (n - i < 0) {
                break;
            }
            combination.push_back(i);
            findCombinations(k - 1, n - i, i + 1, combination, result);
            combination.pop_back();
        }
    }
};