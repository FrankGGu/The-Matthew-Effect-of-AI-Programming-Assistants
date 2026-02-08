#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> trainingPlan(vector<int>& goal) {
        vector<int> result;
        for (int i = 0; i < goal.size(); ++i) {
            if (goal[i] % 2 == 1) {
                result.push_back(goal[i]);
            }
        }
        return result;
    }
};