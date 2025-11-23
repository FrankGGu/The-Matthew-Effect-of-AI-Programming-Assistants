#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canForm(vector<vector<int>>& triplets, vector<int>& target) {
        for (auto& t : triplets) {
            if (t[0] > target[0] || t[1] > target[1] || t[2] > target[2]) {
                continue;
            }
            if (t[0] == target[0] && t[1] == target[1] && t[2] == target[2]) {
                return true;
            }
        }
        return false;
    }
};