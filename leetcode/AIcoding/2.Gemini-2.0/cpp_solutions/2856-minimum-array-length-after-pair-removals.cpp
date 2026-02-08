#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int minArrayLength(vector<int>& nums) {
        priority_queue<int> pq;
        int n = nums.size();

        sort(nums.begin(), nums.end());

        int count = 1;
        for (int i = 1; i < n; ++i) {
            if (nums[i] == nums[i - 1]) {
                count++;
            } else {
                pq.push(count);
                count = 1;
            }
        }
        pq.push(count);

        while (pq.size() > 1) {
            int top1 = pq.top();
            pq.pop();
            int top2 = pq.top();
            pq.pop();

            if (top1 > 1) {
                pq.push(top1 - 1);
            }
            if (top2 > 1) {
                pq.push(top2 - 1);
            }
        }

        if (pq.empty()) return 0;
        else return pq.top();
    }
};