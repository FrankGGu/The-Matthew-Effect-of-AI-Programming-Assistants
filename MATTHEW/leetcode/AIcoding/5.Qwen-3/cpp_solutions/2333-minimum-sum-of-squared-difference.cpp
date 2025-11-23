#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minSumSquareDifference(int n, int k, vector<int>& s) {
        priority_queue<long long> maxHeap;
        for (int num : s) {
            maxHeap.push(num);
        }

        while (k > 0) {
            long long current = maxHeap.top();
            maxHeap.pop();
            long long next = current - 1;
            maxHeap.push(next);
            k--;
        }

        long long result = 0;
        while (!maxHeap.empty()) {
            long long val = maxHeap.top();
            result += val * val;
            maxHeap.pop();
        }

        return static_cast<int>(result);
    }
};