#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxProfitAssignment(vector<int>& difficulty, vector<int>& profit, vector<int>& worker) {
        vector<pair<int, int>> jobs;
        for (int i = 0; i < difficulty.size(); ++i) {
            jobs.emplace_back(difficulty[i], profit[i]);
        }
        sort(jobs.begin(), jobs.end());
        sort(worker.begin(), worker.end());

        int maxProfit = 0, res = 0, i = 0, best = 0;
        for (int ability : worker) {
            while (i < jobs.size() && jobs[i].first <= ability) {
                best = max(best, jobs[i].second);
                ++i;
            }
            res += best;
        }
        return res;
    }
};