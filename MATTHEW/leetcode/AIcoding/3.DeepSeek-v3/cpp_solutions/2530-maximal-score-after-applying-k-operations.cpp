#include <queue>
#include <vector>

using namespace std;

class Solution {
public:
    long long maxKelements(vector<int>& nums, int k) {
        priority_queue<int> maxHeap(nums.begin(), nums.end());
        long long score = 0;

        while (k--) {
            int top = maxHeap.top();
            maxHeap.pop();
            score += top;
            maxHeap.push((top + 2) / 3); // Equivalent to ceil(top / 3)
        }

        return score;
    }
};