#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& target, vector<int>& original) {
        map<int, int> pos;
        for (int i = 0; i < target.size(); ++i) {
            pos[target[i]] = i;
        }

        vector<int> indices;
        for (int num : original) {
            if (pos.find(num) != pos.end()) {
                indices.push_back(pos[num]);
            }
        }

        vector<int> dp;
        for (int num : indices) {
            auto it = lower_bound(dp.begin(), dp.end(), num);
            if (it == dp.end()) {
                dp.push_back(num);
            } else {
                *it = num;
            }
        }

        return target.size() - dp.size();
    }
};