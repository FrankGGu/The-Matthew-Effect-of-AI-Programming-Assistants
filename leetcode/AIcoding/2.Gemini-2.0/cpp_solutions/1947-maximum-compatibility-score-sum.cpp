#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxCompatibilitySum(vector<vector<int>>& students, vector<vector<int>>& mentors) {
        int n = students.size();
        int m = students[0].size();
        vector<int> p(n);
        for (int i = 0; i < n; ++i) {
            p[i] = i;
        }
        int maxSum = 0;
        do {
            int currentSum = 0;
            for (int i = 0; i < n; ++i) {
                int score = 0;
                for (int j = 0; j < m; ++j) {
                    if (students[i][j] == mentors[p[i]][j]) {
                        score++;
                    }
                }
                currentSum += score;
            }
            maxSum = max(maxSum, currentSum);
        } while (next_permutation(p.begin(), p.end()));
        return maxSum;
    }
};