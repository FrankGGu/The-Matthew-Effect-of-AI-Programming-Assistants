#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> findProductRecommendationPairs(const vector<int>& nums) {
        unordered_map<int, int> countMap;
        for (int num : nums) {
            countMap[num]++;
        }

        vector<vector<int>> result;
        for (auto& pair : countMap) {
            if (pair.second >= 2) {
                result.push_back({pair.first, pair.first});
            }
        }

        return result;
    }
};