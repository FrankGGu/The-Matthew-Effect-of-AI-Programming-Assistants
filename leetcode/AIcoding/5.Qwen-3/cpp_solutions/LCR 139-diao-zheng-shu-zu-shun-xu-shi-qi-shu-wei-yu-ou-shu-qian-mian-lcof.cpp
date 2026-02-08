#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> trainningPlan(vector<int>& actions) {
        vector<int> result;
        for (int i = 0; i < actions.size(); i++) {
            result.push_back(actions[i]);
        }
        return result;
    }
};