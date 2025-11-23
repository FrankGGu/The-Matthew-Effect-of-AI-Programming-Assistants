#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maximumBeauty(vector<vector<int>>& items, vector<int>& queries) {
        sort(items.begin(), items.end());
        int n = items.size();
        int m = queries.size();
        vector<int> ans(m);
        vector<pair<int, int>> q;
        for (int i = 0; i < m; ++i) {
            q.push_back({queries[i], i});
        }
        sort(q.begin(), q.end());

        int maxBeauty = 0;
        int itemIndex = 0;
        for (int i = 0; i < m; ++i) {
            int query = q[i].first;
            int queryIndex = q[i].second;

            while (itemIndex < n && items[itemIndex][0] <= query) {
                maxBeauty = max(maxBeauty, items[itemIndex][1]);
                itemIndex++;
            }
            ans[queryIndex] = maxBeauty;
        }

        return ans;
    }
};