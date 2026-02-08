class Solution {
public:
    vector<int> leftmostBuildingQueries(vector<int>& heights, vector<vector<int>>& queries) {
        int n = heights.size();
        vector<int> res(queries.size(), -1);
        vector<vector<pair<int, int>>> q(n);
        for (int i = 0; i < queries.size(); ++i) {
            int a = queries[i][0], b = queries[i][1];
            if (a > b) swap(a, b);
            if (a == b || heights[a] < heights[b]) {
                res[i] = b;
            } else {
                q[b].emplace_back(heights[a], i);
            }
        }
        stack<int> st;
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && heights[st.top()] <= heights[i]) {
                st.pop();
            }
            for (auto [h, idx] : q[i]) {
                int l = 0, r = st.size() - 1;
                int ans = -1;
                while (l <= r) {
                    int mid = l + (r - l) / 2;
                    auto it = st.rbegin() + mid;
                    if (heights[*it] > h) {
                        ans = *it;
                        l = mid + 1;
                    } else {
                        r = mid - 1;
                    }
                }
                res[idx] = ans;
            }
            st.push(i);
        }
        return res;
    }
};