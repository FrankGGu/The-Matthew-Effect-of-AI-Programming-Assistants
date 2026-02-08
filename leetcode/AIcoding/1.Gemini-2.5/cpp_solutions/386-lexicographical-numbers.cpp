#include <vector>

class Solution {
public:
    std::vector<int> result;
    int N_limit;

    void dfs(int current_num) {
        if (current_num > N_limit) {
            return;
        }
        result.push_back(current_num);
        for (int i = 0; i <= 9; ++i) {
            int next_num = current_num * 10 + i;
            if (next_num > N_limit) {
                break;
            }
            dfs(next_num);
        }
    }

    std::vector<int> lexicographicalNumbers(int n) {
        N_limit = n;
        result.reserve(n);
        result.clear(); 
        for (int i = 1; i <= 9; ++i) {
            if (i > N_limit) {
                break;
            }
            dfs(i);
        }
        return result;
    }
};