#include <iostream>
#include <vector>
#include <stack>
#include <unordered_map>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    int maxProfitAssignment(vector<int>& skill, vector<int>& profit, vector<vector<int>>& workers) {
        vector<pair<int, int>> jobs;
        for (int i = 0; i < skill.size(); ++i) {
            jobs.push_back({skill[i], profit[i]});
        }
        sort(jobs.begin(), jobs.end());
        vector<int> sortedSkill;
        vector<int> sortedProfit;
        for (auto& job : jobs) {
            sortedSkill.push_back(job.first);
            sortedProfit.push_back(job.second);
        }
        for (int i = 1; i < sortedProfit.size(); ++i) {
            sortedProfit[i] = max(sortedProfit[i], sortedProfit[i - 1]);
        }
        int res = 0;
        for (auto& worker : workers) {
            int s = worker[0];
            int l = 0, r = sortedSkill.size() - 1;
            int idx = -1;
            while (l <= r) {
                int mid = l + (r - l) / 2;
                if (sortedSkill[mid] <= s) {
                    idx = mid;
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            }
            if (idx != -1) {
                res += sortedProfit[idx];
            }
        }
        return res;
    }
};