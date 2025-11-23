#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long maxKelements(vector<int>& nums, int k) {
        priority_queue<int> pq;
        for (int num : nums) {
            pq.push(num);
        }

        long long score = 0;
        for (int i = 0; i < k; ++i) {
            int top = pq.top();
            pq.pop();
            score += top;
            pq.push((top + 2) / 3);
        }

        return score;
    }
};