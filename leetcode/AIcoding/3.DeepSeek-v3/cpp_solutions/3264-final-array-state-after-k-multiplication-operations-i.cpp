#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> kMultiply(vector<int>& nums, int k) {
        priority_queue<int, vector<int>, greater<int>> minHeap;
        for (int num : nums) {
            minHeap.push(num);
        }
        for (int i = 0; i < k; ++i) {
            int smallest = minHeap.top();
            minHeap.pop();
            minHeap.push(smallest * 2);
        }
        vector<int> result;
        while (!minHeap.empty()) {
            result.push_back(minHeap.top());
            minHeap.pop();
        }
        sort(result.begin(), result.end());
        return result;
    }
};