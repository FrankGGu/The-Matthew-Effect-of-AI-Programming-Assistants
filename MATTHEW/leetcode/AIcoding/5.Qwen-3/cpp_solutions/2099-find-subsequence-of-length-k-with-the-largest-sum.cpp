#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>

using namespace std;

class Solution {
public:
    vector<int> maxSubsequenceWithKLength(vector<int>& nums, int k) {
        vector<pair<int, int>> indexedNums;
        for (int i = 0; i < nums.size(); ++i) {
            indexedNums.push_back({nums[i], i});
        }

        sort(indexedNums.begin(), indexedNums.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first > b.first;
        });

        vector<pair<int, int>> selected;
        for (int i = 0; i < k; ++i) {
            selected.push_back(indexedNums[i]);
        }

        sort(selected.begin(), selected.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.second < b.second;
        });

        vector<int> result;
        for (const auto& p : selected) {
            result.push_back(p.first);
        }

        return result;
    }
};