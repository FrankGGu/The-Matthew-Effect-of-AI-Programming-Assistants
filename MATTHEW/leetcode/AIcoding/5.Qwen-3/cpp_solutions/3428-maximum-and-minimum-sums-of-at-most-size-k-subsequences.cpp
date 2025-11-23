#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<long long> maxSubsequenceSum(vector<int>& nums, int k) {
        int n = nums.size();
        vector<pair<int, int>> indexed_nums;
        for (int i = 0; i < n; ++i) {
            indexed_nums.push_back({nums[i], i});
        }

        sort(indexed_nums.begin(), indexed_nums.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first > b.first;
        });

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> min_heap;
        long long sum = 0;
        vector<int> indices;

        for (int i = 0; i < k; ++i) {
            sum += indexed_nums[i].first;
            min_heap.push({indexed_nums[i].second, indexed_nums[i].first});
        }

        while (!min_heap.empty()) {
            indices.push_back(min_heap.top().first);
            min_heap.pop();
        }

        sort(indices.begin(), indices.end());

        vector<long long> result = {sum, 0};
        for (int i = 0; i < indices.size(); ++i) {
            result[1] += nums[indices[i]];
        }

        return result;
    }
};