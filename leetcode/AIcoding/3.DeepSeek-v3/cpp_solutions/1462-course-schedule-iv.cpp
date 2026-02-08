class Solution {
public:
    vector<bool> checkIfPrerequisite(int numCourses, vector<vector<int>>& prerequisites, vector<vector<int>>& queries) {
        vector<vector<bool>> isReachable(numCourses, vector<bool>(numCourses, false));
        for (const auto& pre : prerequisites) {
            isReachable[pre[0]][pre[1]] = true;
        }

        for (int k = 0; k < numCourses; ++k) {
            for (int i = 0; i < numCourses; ++i) {
                for (int j = 0; j < numCourses; ++j) {
                    if (isReachable[i][k] && isReachable[k][j]) {
                        isReachable[i][j] = true;
                    }
                }
            }
        }

        vector<bool> result;
        for (const auto& query : queries) {
            result.push_back(isReachable[query[0]][query[1]]);
        }
        return result;
    }
};