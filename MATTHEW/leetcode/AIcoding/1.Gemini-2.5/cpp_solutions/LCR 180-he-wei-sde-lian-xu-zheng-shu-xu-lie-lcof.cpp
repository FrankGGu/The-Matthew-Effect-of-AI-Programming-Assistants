#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(vector<int>& costs) {
        if (costs.size() <= 1) {
            return 0;
        }

        priority_queue<long long, vector<long long>, greater<long long>> pq;
        for (int cost : costs) {
            pq.push(cost);
        }

        long long totalCost = 0;
        while (pq.size() > 1) {
            long long first = pq.top();
            pq.pop();
            long long second = pq.top();
            pq.pop();

            long long combinedCost = first + second;
            totalCost += combinedCost;
            pq.push(combinedCost);
        }

        return (int)totalCost;
    }
};