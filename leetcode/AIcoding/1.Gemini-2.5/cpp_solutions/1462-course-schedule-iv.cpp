class Solution {
public:
    std::vector<bool> checkIfPrerequisite(int n, std::vector<std::vector<int>>& prerequisites, std::vector<std::vector<int>>& queries) {
        std::vector<std::vector<bool>> reachable(n, std::vector<bool>(n, false));

        for (const auto& pre : prerequisites) {
            reachable[pre[0]][pre[1]] = true;
        }

        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (reachable[i][k] && reachable[k][j]) {
                        reachable[i][j] = true;
                    }
                }
            }
        }

        std::vector<bool> result;
        for (const auto& query : queries) {
            result.push_back(reachable[query[0]][query[1]]);
        }

        return result;
    }
};