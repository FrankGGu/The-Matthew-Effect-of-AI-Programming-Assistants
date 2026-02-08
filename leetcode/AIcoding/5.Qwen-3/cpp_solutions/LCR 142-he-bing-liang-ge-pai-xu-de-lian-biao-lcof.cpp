#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int trainingPlan(vector<int>& actions) {
        unordered_map<int, int> countMap;
        for (int action : actions) {
            countMap[action]++;
        }
        for (int action : actions) {
            if (countMap[action] == 1) {
                return action;
            }
        }
        return -1;
    }
};