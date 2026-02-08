#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int maxScore(vector<vector<int>>& students, vector<vector<int>>& mentors) {
        int n = students.size();
        int m = students[0].size();
        vector<int> perm(n);
        for (int i = 0; i < n; ++i) {
            perm[i] = i;
        }
        int maxScore = 0;
        do {
            int score = 0;
            for (int i = 0; i < n; ++i) {
                int s = 0;
                for (int j = 0; j < m; ++j) {
                    s += abs(students[i][j] - mentors[perm[i]][j]);
                }
                score += s;
            }
            maxScore = max(maxScore, score);
        } while (next_permutation(perm.begin(), perm.end()));
        return maxScore;
    }
};