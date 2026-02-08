#include <vector>
#include <queue>
#include <algorithm>
#include <limits.h>

using namespace std;

class Solution {
public:
    int minimumDeviation(vector<int>& nums) {
        priority_queue<int> maxHeap;
        int minNum = INT_MAX;

        for (int num : nums) {
            if (num % 2 == 0) {
                maxHeap.push(num);
                minNum = min(minNum, num);
            } else {
                maxHeap.push(num * 2);
                minNum = min(minNum, num * 2);
            }
        }

        int minDeviation = INT_MAX;

        while (!maxHeap.empty()) {
            int maxNum = maxHeap.top();
            maxHeap.pop();
            minDeviation = min(minDeviation, maxNum - minNum);

            if (maxNum % 2 == 0) {
                minNum = min(minNum, maxNum / 2);
                maxHeap.push(maxNum / 2);
            } else {
                break;
            }
        }

        return minDeviation;
    }
};