#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int findLeastNumOfUniqueInts(vector<int>& arr, int k) {
        unordered_map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> minHeap;
        for (auto& [num, freq] : count) {
            minHeap.push({freq, num});
        }

        while (k > 0 && !minHeap.empty()) {
            auto [freq, num] = minHeap.top();
            if (freq <= k) {
                k -= freq;
                minHeap.pop();
            } else {
                break;
            }
        }

        return minHeap.size();
    }
};