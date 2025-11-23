#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> minInterval(vector<vector<int>>& intervals, vector<int>& queries) {
        int n = intervals.size();
        int m = queries.size();
        vector<int> ans(m);
        vector<pair<int, int>> q;
        for (int i = 0; i < m; ++i) {
            q.push_back({queries[i], i});
        }
        sort(q.begin(), q.end());
        sort(intervals.begin(), intervals.end(), [](const auto& a, const auto& b) {
            return a[0] < b[0];
        });

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        int i = 0;
        for (auto& [query, idx] : q) {
            while (i < n && intervals[i][0] <= query) {
                pq.push({intervals[i][1] - intervals[i][0] + 1, intervals[i][1]});
                i++;
            }
            while (!pq.empty() && pq.top().second < query) {
                pq.pop();
            }
            if (pq.empty()) {
                ans[idx] = -1;
            } else {
                ans[idx] = pq.top().first;
            }
        }

        return ans;
    }
};