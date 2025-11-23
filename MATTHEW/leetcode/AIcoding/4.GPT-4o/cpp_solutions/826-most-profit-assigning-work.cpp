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

        int maxProfit = 0, j = 0, bestProfit = 0;
        for (int w : worker) {
            while (j < jobs.size() && jobs[j].first <= w) {
                bestProfit = max(bestProfit, jobs[j].second);
                j++;
            }
            maxProfit += bestProfit;
        }

        return maxProfit;
    }
};