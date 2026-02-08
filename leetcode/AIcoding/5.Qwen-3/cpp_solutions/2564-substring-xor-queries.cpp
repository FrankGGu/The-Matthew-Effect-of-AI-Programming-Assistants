#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> substringXOR(vector<int>& nums, vector<vector<int>>& queries) {
        vector<vector<int>> result;
        unordered_map<int, int> prefixXOR;
        prefixXOR[0] = -1;
        int currentXOR = 0;
        for (int i = 0; i < nums.size(); ++i) {
            currentXOR ^= nums[i];
            prefixXOR[currentXOR] = i;
        }

        for (auto& q : queries) {
            int val = q[0];
            int target = q[1];
            int desired = val ^ target;
            if (prefixXOR.find(desired) != prefixXOR.end()) {
                result.push_back({prefixXOR[desired], i});
            } else {
                result.push_back({-1, -1});
            }
        }

        return result;
    }
};