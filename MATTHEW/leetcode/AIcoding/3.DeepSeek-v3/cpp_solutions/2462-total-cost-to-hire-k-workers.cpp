#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long totalCost(vector<int>& costs, int k, int candidates) {
        priority_queue<int, vector<int>, greater<int>> leftHeap, rightHeap;
        int left = 0, right = costs.size() - 1;
        long long res = 0;

        while (k--) {
            while (leftHeap.size() < candidates && left <= right) {
                leftHeap.push(costs[left++]);
            }
            while (rightHeap.size() < candidates && left <= right) {
                rightHeap.push(costs[right--]);
            }

            int leftMin = leftHeap.empty() ? INT_MAX : leftHeap.top();
            int rightMin = rightHeap.empty() ? INT_MAX : rightHeap.top();

            if (leftMin <= rightMin) {
                res += leftMin;
                leftHeap.pop();
            } else {
                res += rightMin;
                rightHeap.pop();
            }
        }
        return res;
    }
};