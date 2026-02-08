#include <iostream>
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

        int res = 0;
        int j = 0;
        int maxProfit = 0;

        for (int w : worker) {
            while (j < jobs.size() && jobs[j].first <= w) {
                maxProfit = max(maxProfit, jobs[j].second);
                ++j;
            }
            res += maxProfit;
        }

        return res;
    }
};