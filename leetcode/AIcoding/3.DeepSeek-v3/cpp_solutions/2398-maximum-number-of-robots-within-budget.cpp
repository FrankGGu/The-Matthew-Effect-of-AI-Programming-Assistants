#include <vector>
#include <deque>
using namespace std;

class Solution {
public:
    int maximumRobots(vector<int>& chargeTimes, vector<int>& runningCosts, long long budget) {
        int n = chargeTimes.size();
        deque<int> dq;
        int left = 0;
        long long sum = 0;
        int max_len = 0;

        for (int right = 0; right < n; ++right) {
            sum += runningCosts[right];

            while (!dq.empty() && chargeTimes[dq.back()] <= chargeTimes[right]) {
                dq.pop_back();
            }
            dq.push_back(right);

            while (left <= right && chargeTimes[dq.front()] + (right - left + 1) * sum > budget) {
                if (dq.front() == left) {
                    dq.pop_front();
                }
                sum -= runningCosts[left];
                left++;
            }

            if (chargeTimes[dq.front()] + (right - left + 1) * sum <= budget) {
                max_len = max(max_len, right - left + 1);
            }
        }

        return max_len;
    }
};