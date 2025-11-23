#include <vector>
#include <queue>
#include <cmath>

using namespace std;

class Solution {
public:
    long long pickGifts(vector<int>& gifts, int k) {
        priority_queue<int> maxHeap;
        for (int gift : gifts) {
            maxHeap.push(gift);
        }

        while (k-- > 0 && !maxHeap.empty()) {
            int top = maxHeap.top();
            maxHeap.pop();
            int remaining = sqrt(top);
            maxHeap.push(remaining);
        }

        long long total = 0;
        while (!maxHeap.empty()) {
            total += maxHeap.top();
            maxHeap.pop();
        }

        return total;
    }
};