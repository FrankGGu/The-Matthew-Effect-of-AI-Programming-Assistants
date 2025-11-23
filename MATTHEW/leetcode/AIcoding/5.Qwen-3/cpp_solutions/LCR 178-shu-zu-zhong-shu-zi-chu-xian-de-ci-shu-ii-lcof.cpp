#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int trainningPlan(vector<int>& actions) {
        unordered_map<int, int> count;
        for (int action : actions) {
            count[action]++;
        }
        for (int action : actions) {
            if (count[action] == 1) {
                return action;
            }
        }
        return -1;
    }
};