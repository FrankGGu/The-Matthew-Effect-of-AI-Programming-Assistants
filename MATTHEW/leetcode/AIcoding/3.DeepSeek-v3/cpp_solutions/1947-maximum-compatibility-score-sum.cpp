class Solution {
public:
    int maxCompatibilitySum(vector<vector<int>>& students, vector<vector<int>>& mentors) {
        int m = students.size();
        int n = students[0].size();
        vector<vector<int>> score(m, vector<int>(m));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < m; ++j) {
                int s = 0;
                for (int k = 0; k < n; ++k) {
                    if (students[i][k] == mentors[j][k]) {
                        s++;
                    }
                }
                score[i][j] = s;
            }
        }

        vector<int> perm(m);
        for (int i = 0; i < m; ++i) {
            perm[i] = i;
        }

        int maxScore = 0;
        do {
            int current = 0;
            for (int i = 0; i < m; ++i) {
                current += score[i][perm[i]];
            }
            maxScore = max(maxScore, current);
        } while (next_permutation(perm.begin(), perm.end()));

        return maxScore;
    }
};