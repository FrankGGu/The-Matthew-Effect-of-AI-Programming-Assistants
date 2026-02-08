#include <vector>
#include <algorithm>
#include <set>
#include <tuple>

using namespace std;

class Solution {
public:
    vector<int> minInterval(vector<vector<int>>& intervals, vector<int>& queries) {
        sort(intervals.begin(), intervals.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] < b[0];
        });
        vector<pair<int, int>> sortedQueries;
        for (int i = 0; i < queries.size(); ++i) {
            sortedQueries.emplace_back(queries[i], i);
        }
        sort(sortedQueries.begin(), sortedQueries.end());

        vector<int> result(queries.size(), -1);
        multiset<int> activeIntervals;

        int j = 0;
        for (const auto& [query, index] : sortedQueries) {
            while (j < intervals.size() && intervals[j][0] <= query) {
                activeIntervals.insert(intervals[j][1] - intervals[j][0] + 1);
                j++;
            }
            while (!activeIntervals.empty() && intervals[activeIntervals.begin()->first][1] < query) {
                activeIntervals.erase(activeIntervals.begin());
            }
            if (!activeIntervals.empty()) {
                result[index] = *activeIntervals.begin();
            }
        }
        return result;
    }
};