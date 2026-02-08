#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int trainningPlan(vector<int>& goal) {
        int count = 0;
        for (int i = 0; i < goal.size(); ++i) {
            if (goal[i] == 0) {
                ++count;
            }
        }
        return count;
    }
};