#include <vector>
#include <algorithm>
#include <queue>
using namespace std;

class Solution {
public:
    vector<int> minInterval(vector<vector<int>>& intervals, vector<int>& queries) {
        sort(intervals.begin(), intervals.end());
        vector<pair<int, int>> sortedQueries;
        for (int i = 0; i < queries.size(); ++i) {
            sortedQueries.push_back({queries[i], i});
        }
        sort(sortedQueries.begin(), sortedQueries.end());

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        vector<int> result(queries.size(), -1);
        int i = 0;
        for (auto& query : sortedQueries) {
            int x = query.first;
            int idx = query.second;

            while (i < intervals.size() && intervals[i][0] <= x) {
                int left = intervals[i][0];
                int right = intervals[i][1];
                int length = right - left + 1;
                pq.push({length, right});
                i++;
            }

            while (!pq.empty() && pq.top().second < x) {
                pq.pop();
            }

            if (!pq.empty()) {
                result[idx] = pq.top().first;
            }
        }
        return result;
    }
};