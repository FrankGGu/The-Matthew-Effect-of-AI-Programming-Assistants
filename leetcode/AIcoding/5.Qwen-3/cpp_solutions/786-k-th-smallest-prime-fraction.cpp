#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> kthSmallestPrimeFraction(vector<int>& A, int k) {
        priority_queue<pair<double, pair<int, int>>, vector<pair<double, pair<int, int>>>, greater<>> minHeap;

        for (int i = 0; i < A.size(); ++i) {
            minHeap.push({(double)A[i] / A.back(), {i, A.size() - 1}});
        }

        while (--k > 0) {
            auto top = minHeap.top();
            minHeap.pop();
            int i = top.second.first;
            int j = top.second.second;
            if (j - 1 >= i) {
                minHeap.push({(double)A[i] / A[j - 1], {i, j - 1}});
            }
        }

        auto result = minHeap.top().second;
        return {A[result.first], A[result.second]};
    }
};