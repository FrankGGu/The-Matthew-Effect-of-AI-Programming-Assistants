#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long totalCostToHireKWorkers(vector<int>& costs, int k) {
        priority_queue<int, vector<int>, greater<int>> minHeap1;
        priority_queue<int, vector<int>, greater<int>> minHeap2;

        for (int cost : costs) {
            minHeap1.push(cost);
        }

        long long totalCost = 0;
        int workersHired = 0;

        while (workersHired < k) {
            int top1 = minHeap1.empty() ? INT_MAX : minHeap1.top();
            int top2 = minHeap2.empty() ? INT_MAX : minHeap2.top();

            if (top1 <= top2) {
                totalCost += top1;
                minHeap1.pop();
            } else {
                totalCost += top2;
                minHeap2.pop();
            }
            workersHired++;
        }

        return totalCost;
    }
};