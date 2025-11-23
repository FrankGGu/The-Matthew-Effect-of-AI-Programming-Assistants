#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> mergeArrays(vector<vector<int>>& nums1, vector<vector<int>>& nums2) {
        map<int, int> merged;
        for (auto& row : nums1) {
            merged[row[0]] += row[1];
        }
        for (auto& row : nums2) {
            merged[row[0]] += row[1];
        }

        vector<vector<int>> result;
        for (auto& pair : merged) {
            result.push_back({pair.first, pair.second});
        }

        return result;
    }
};