#include <iostream>
#include <vector>
#include <queue>
#include <functional>

using namespace std;

class Solution {
public:
    int maxEatenApple(int n, vector<int>& apples, vector<int>& days) {
        int time = 0;
        int result = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> minHeap;

        for (int i = 0; i < n; ++i) {
            if (apples[i] > 0) {
                int expireTime = time + days[i];
                minHeap.push({expireTime, apples[i]});
            }

            while (!minHeap.empty() && minHeap.top().first <= time) {
                minHeap.pop();
            }

            if (!minHeap.empty()) {
                auto [expire, count] = minHeap.top();
                minHeap.pop();
                result++;
                if (count > 1) {
                    minHeap.push({expire, count - 1});
                }
            }

            time++;
        }

        while (!minHeap.empty()) {
            while (!minHeap.empty() && minHeap.top().first <= time) {
                minHeap.pop();
            }

            if (!minHeap.empty()) {
                auto [expire, count] = minHeap.top();
                minHeap.pop();
                result++;
                if (count > 1) {
                    minHeap.push({expire, count - 1});
                }
            }

            time++;
        }

        return result;
    }
};