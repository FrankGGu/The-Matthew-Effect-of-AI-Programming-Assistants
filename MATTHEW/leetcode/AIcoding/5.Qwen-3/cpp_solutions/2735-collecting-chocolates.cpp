#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minCostToCollectAllChocolates(vector<int>& chocolates, vector<int>& cost) {
        int n = chocolates.size();
        vector<int> freq(n, 0);

        for (int i = 0; i < n; ++i) {
            freq[chocolates[i]]++;
        }

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;

        for (int i = 0; i < n; ++i) {
            if (freq[i] > 0) {
                pq.push({cost[i], i});
            }
        }

        int totalCost = 0;

        while (!pq.empty()) {
            auto [currentCost, index] = pq.top();
            pq.pop();

            totalCost += currentCost;

            for (int i = 0; i < n; ++i) {
                if (chocolates[i] == index) {
                    freq[index]--;
                    if (freq[index] > 0) {
                        pq.push({currentCost + cost[i], index});
                        break;
                    }
                }
            }
        }

        return totalCost;
    }
};