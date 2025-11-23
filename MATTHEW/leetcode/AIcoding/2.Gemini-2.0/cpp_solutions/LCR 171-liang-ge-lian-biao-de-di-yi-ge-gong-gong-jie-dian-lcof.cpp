#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int trainingPlan(vector<int>& actions, int k) {
        int n = actions.size();
        vector<int> current_actions = actions;
        for (int i = 0; i < k; ++i) {
            vector<int> next_actions(n);
            for (int j = 0; j < n; ++j) {
                if (current_actions[j] == 0) {
                    next_actions[j] = current_actions[(j - 1 + n) % n];
                } else {
                    next_actions[j] = current_actions[(j + 1) % n];
                }
            }
            current_actions = next_actions;
        }
        return accumulate(current_actions.begin(), current_actions.end(), 0);
    }
};