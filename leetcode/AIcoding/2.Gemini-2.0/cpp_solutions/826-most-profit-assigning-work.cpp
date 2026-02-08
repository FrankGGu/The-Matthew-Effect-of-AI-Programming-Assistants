#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProfitAssignment(vector<int>& difficulty, vector<int>& profit, vector<int>& worker) {
        vector<pair<int, int>> jobs;
        for (int i = 0; i < difficulty.size(); ++i) {
            jobs.push_back({difficulty[i], profit[i]});
        }

        sort(jobs.begin(), jobs.end());
        sort(worker.begin(), worker.end());

        int max_profit = 0;
        int job_idx = 0;
        int best_profit = 0;

        for (int i = 0; i < worker.size(); ++i) {
            while (job_idx < jobs.size() && jobs[job_idx].first <= worker[i]) {
                best_profit = max(best_profit, jobs[job_idx].second);
                job_idx++;
            }
            max_profit += best_profit;
        }

        return max_profit;
    }
};