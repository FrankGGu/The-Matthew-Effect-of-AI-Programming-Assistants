#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    int maximumRobots(vector<int>& costs, vector<int>& runningCosts, long long budget) {
        int n = costs.size();
        int left = 0, right = 0;
        deque<int> dq;
        long long currentCost = 0;
        int maxRobots = 0;

        while (right < n) {
            currentCost += runningCosts[right];

            while (!dq.empty() && costs[dq.back()] < costs[right]) {
                dq.pop_back();
            }
            dq.push_back(right);

            while (!dq.empty() && costs[dq.front()] + (right - left + 1) * currentCost > budget) {
                currentCost -= runningCosts[left];
                if (dq.front() == left) {
                    dq.pop_front();
                }
                left++;
            }

            maxRobots = max(maxRobots, right - left + 1);
            right++;
        }

        return maxRobots;
    }
};