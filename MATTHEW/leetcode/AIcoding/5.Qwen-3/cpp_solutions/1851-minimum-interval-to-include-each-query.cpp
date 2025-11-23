#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> minIntervalToIncludeEachQuery(vector<vector<int>>& intervals, vector<int>& queries) {
        sort(intervals.begin(), intervals.end());
        vector<pair<int, int>> sortedQueries;
        for (int i = 0; i < queries.size(); ++i) {
            sortedQueries.push_back({queries[i], i});
        }
        sort(sortedQueries.begin(), sortedQueries.end());

        vector<int> result(queries.size());
        int i = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> minHeap;

        for (auto& [query, index] : sortedQueries) {
            while (i < intervals.size() && intervals[i][0] <= query) {
                minHeap.push({intervals[i][1] - intervals[i][0] + 1, intervals[i][1]});
                ++i;
            }

            while (!minHeap.empty() && minHeap.top().second < query) {
                minHeap.pop();
            }

            if (!minHeap.empty()) {
                result[index] = minHeap.top().first;
            } else {
                result[index] = -1;
            }
        }

        return result;
    }
};