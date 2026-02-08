#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int findScore(vector<int>& nums) {
        int n = nums.size();
        map<int, vector<int>> pos;
        for (int i = 0; i < n; ++i) {
            pos[nums[i]].push_back(i);
        }

        vector<bool> marked(n, false);
        int score = 0;

        for (auto it = pos.begin(); it != pos.end(); ++it) {
            int val = it->first;
            for (int idx : it->second) {
                if (!marked[idx]) {
                    score += val;
                    marked[idx] = true;
                    if (idx > 0) marked[idx - 1] = true;
                    if (idx < n - 1) marked[idx + 1] = true;
                }
            }
        }

        return score;
    }
};