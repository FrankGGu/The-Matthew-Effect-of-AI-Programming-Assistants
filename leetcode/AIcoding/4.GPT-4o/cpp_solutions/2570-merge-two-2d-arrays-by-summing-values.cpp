#include <vector>
#include <unordered_map>
using namespace std;

vector<vector<int>> mergeArrays(vector<vector<int>>& nums1, vector<vector<int>>& nums2) {
    unordered_map<int, int> sumMap;
    for (const auto& pair : nums1) {
        sumMap[pair[0]] += pair[1];
    }
    for (const auto& pair : nums2) {
        sumMap[pair[0]] += pair[1];
    }
    vector<vector<int>> result;
    for (const auto& [key, value] : sumMap) {
        result.push_back({key, value});
    }
    sort(result.begin(), result.end());
    return result;
}