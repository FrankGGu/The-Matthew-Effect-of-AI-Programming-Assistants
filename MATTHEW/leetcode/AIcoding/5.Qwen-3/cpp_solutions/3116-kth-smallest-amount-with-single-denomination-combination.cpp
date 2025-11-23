#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long kthSmallestEnough(vector<int>& coins, int k) {
        priority_queue<long long, vector<long long>, greater<long long>> minHeap;
        minHeap.push(0);
        int count = 0;
        while (!minHeap.empty()) {
            long long current = minHeap.top();
            minHeap.pop();
            if (count == k - 1) {
                return current;
            }
            count++;
            for (int coin : coins) {
                if (current + coin <= (long long)INT_MAX) {
                    minHeap.push(current + coin);
                }
            }
        }
        return -1;
    }

    long long findKthSmallest(vector<int>& coins, int k) {
        return kthSmallestEnough(coins, k);
    }
};