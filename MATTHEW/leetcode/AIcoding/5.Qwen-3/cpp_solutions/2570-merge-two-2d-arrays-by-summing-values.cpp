#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> mergeArrays(vector<vector<int>>& nums1, vector<vector<int>>& nums2) {
        map<int, int> sumMap;
        for (const auto& arr : nums1) {
            sumMap[arr[0]] += arr[1];
        }
        for (const auto& arr : nums2) {
            sumMap[arr[0]] += arr[1];
        }
        vector<vector<int>> result;
        for (const auto& pair : sumMap) {
            result.push_back({pair.first, pair.second});
        }
        return result;
    }
};