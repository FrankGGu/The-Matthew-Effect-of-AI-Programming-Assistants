#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maximumSumQueries(vector<int>& nums1, vector<int>& nums2, vector<vector<int>>& queries) {
        int n = nums1.size();
        int q = queries.size();
        vector<pair<int, int>> arr(n);
        for (int i = 0; i < n; ++i) {
            arr[i] = {nums1[i], nums2[i]};
        }
        sort(arr.begin(), arr.end(), greater<pair<int, int>>());

        vector<tuple<int, int, int>> qs(q);
        for (int i = 0; i < q; ++i) {
            qs[i] = {queries[i][0], queries[i][1], i};
        }
        sort(qs.begin(), qs.end(), greater<tuple<int, int, int>>());

        vector<int> ans(q, -1);
        vector<pair<int, int>> st;

        int j = 0;
        for (int i = 0; i < q; ++i) {
            int x = get<0>(qs[i]);
            int y = get<1>(qs[i]);
            int idx = get<2>(qs[i]);

            while (j < n && arr[j].first >= x) {
                int currX = arr[j].first;
                int currY = arr[j].second;
                int sum = currX + currY;

                while (!st.empty() && st.back().second <= sum) {
                    st.pop_back();
                }
                st.push_back({currY, sum});
                j++;
            }

            int left = 0;
            int right = st.size() - 1;
            int best = -1;

            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (st[mid].first >= y) {
                    best = st[mid].second;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            ans[idx] = best;
        }

        return ans;
    }
};