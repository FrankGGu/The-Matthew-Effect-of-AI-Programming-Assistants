#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> trainingPlan(vector<int>& tasks, int k) {
        int n = tasks.size();
        vector<int> ans;
        vector<bool> used(n, false);

        for (int i = 0; i < n; ++i) {
            int min_val = INT_MAX;
            int min_idx = -1;
            for (int j = 0; j < n; ++j) {
                if (!used[j] && tasks[j] < min_val) {
                    min_val = tasks[j];
                    min_idx = j;
                }
            }

            if (min_idx != -1) {
                ans.push_back(min_val);
                used[min_idx] = true;
            }
        }

        return ans;
    }
};