#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int campSite(vector<int>& nums, int k) {
        int n = nums.size();
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> minHeap;
        for (auto& [num, freq] : count) {
            minHeap.push({freq, num});
        }

        while (minHeap.size() > k) {
            auto [freq, num] = minHeap.top();
            minHeap.pop();
            if (freq > 1) {
                minHeap.push({freq - 1, num});
            }
        }

        int result = 0;
        while (!minHeap.empty()) {
            result += minHeap.top().second;
            minHeap.pop();
        }

        return result;
    }
};