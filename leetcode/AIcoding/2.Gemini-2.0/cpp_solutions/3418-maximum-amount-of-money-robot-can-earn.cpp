#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumRobots(vector<int>& chargeTimes, vector<int>& runningCosts, int budget) {
        int n = chargeTimes.size();
        long long ans = 0;
        int l = 0, r = 0;
        long long sumCosts = 0;
        vector<int> dq;

        while (r < n) {
            sumCosts += runningCosts[r];

            while (!dq.empty() && chargeTimes[dq.back()] <= chargeTimes[r]) {
                dq.pop_back();
            }
            dq.push_back(r);

            while ((long long)chargeTimes[dq.front()] + (long long)(r - l + 1) * sumCosts > budget) {
                if (dq.front() == l) {
                    dq.erase(dq.begin());
                }
                sumCosts -= runningCosts[l];
                l++;
            }

            ans = max(ans, (long long)(r - l + 1));
            r++;
        }

        return ans;
    }
};