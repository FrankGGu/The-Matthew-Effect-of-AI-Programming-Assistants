#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> trainingPlan(vector<int>& plan) {
        int n = plan.size();
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n - 1; ++j) {
                if (plan[j] > plan[j + 1]) {
                    swap(plan[j], plan[j + 1]);
                }
            }
        }
        return plan;
    }
};