#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int pickGifts(vector<int>& gifts, int k) {
        priority_queue<int> maxHeap(gifts.begin(), gifts.end());

        for (int i = 0; i < k; ++i) {
            int top = maxHeap.top();
            maxHeap.pop();
            maxHeap.push(top / 2);
        }

        int total = 0;
        while (!maxHeap.empty()) {
            total += maxHeap.top();
            maxHeap.pop();
        }

        return total;
    }
};