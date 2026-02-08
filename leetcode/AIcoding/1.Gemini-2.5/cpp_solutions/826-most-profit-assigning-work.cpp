#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    int maxProfitAssignment(std::vector<int>& difficulty, std::vector<int>& profit, std::vector<int>& worker) {
        std::vector<std::pair<int, int>> jobs;
        for (size_t i = 0; i < difficulty.size(); ++i) {
            jobs.push_back({difficulty[i], profit[i]});
        }

        std::sort(jobs.begin(), jobs.end());
        std::sort(worker.begin(), worker.end());

        int totalProfit = 0;
        int maxProfit = 0;
        int jobIndex = 0;
        const int n = jobs.size();

        for (int ability : worker) {
            while (jobIndex < n && jobs[jobIndex].first <= ability) {
                maxProfit = std::max(maxProfit, jobs[jobIndex].second);
                jobIndex++;
            }
            totalProfit += maxProfit;
        }

        return totalProfit;
    }
};