#include <iostream>
#include <vector>
#include <map>
#include <unordered_map>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> query(int n, vector<vector<int>>& queries) {
        vector<int> result;
        map<int, vector<int>> pos;
        for (int i = 0; i < n; ++i) {
            pos[i].push_back(i);
        }
        for (auto& q : queries) {
            int left = q[0], right = q[1], target = q[2];
            auto it = pos.find(target);
            if (it == pos.end()) {
                result.push_back(-1);
                continue;
            }
            vector<int>& indices = it->second;
            int l = lower_bound(indices.begin(), indices.end(), left) - indices.begin();
            int r = upper_bound(indices.begin(), indices.end(), right) - indices.begin();
            if (r - l > (right - left + 1) / 2) {
                result.push_back(target);
            } else {
                result.push_back(-1);
            }
        }
        return result;
    }
};