#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> markElements(vector<int>& nums, vector<vector<int>>& queries) {
        vector<int> result(nums.size(), 0);
        unordered_map<int, int> countMap;

        for (int i = 0; i < nums.size(); ++i) {
            countMap[nums[i]]++;
        }

        for (const auto& query : queries) {
            int val = query[0];
            int k = query[1];
            if (countMap.find(val) != countMap.end()) {
                int index = -1;
                for (int i = 0; i < nums.size(); ++i) {
                    if (nums[i] == val && result[i] == 0) {
                        result[i] = k;
                        index = i;
                        break;
                    }
                }
                if (index != -1) {
                    countMap[val]--;
                    if (countMap[val] == 0) {
                        countMap.erase(val);
                    }
                }
            }
        }

        return result;
    }
};