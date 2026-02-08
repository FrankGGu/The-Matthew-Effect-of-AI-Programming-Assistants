#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums, int k) {
        priority_queue<int> maxHeap;
        for (int num : nums) {
            maxHeap.push(num);
        }

        long long score = 0;
        for (int i = 0; i < k; ++i) {
            int current = maxHeap.top();
            maxHeap.pop();
            score += current;
            maxHeap.push(current / 2);
        }

        return score;
    }
};