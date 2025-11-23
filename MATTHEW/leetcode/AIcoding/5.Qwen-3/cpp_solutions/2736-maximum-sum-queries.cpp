#include <iostream>
#include <vector>
#include <stack>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maximumSumQueries(vector<int>& nums1, vector<int>& nums2, vector<vector<int>>& queries) {
        int n = nums1.size();
        int q = queries.size();
        vector<pair<int, int>> numPairs(n);
        for (int i = 0; i < n; ++i) {
            numPairs[i] = {nums1[i], nums2[i]};
        }

        vector<pair<int, int>> sortedNums = numPairs;
        sort(sortedNums.begin(), sortedNums.end());

        vector<int> maxSums(n, 0);
        stack<int> st;
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && sortedNums[st.top()].second <= sortedNums[i].second) {
                st.pop();
            }
            if (!st.empty()) {
                maxSums[i] = sortedNums[i].first + sortedNums[st.top()].second;
            } else {
                maxSums[i] = sortedNums[i].first + sortedNums[i].second;
            }
            st.push(i);
        }

        vector<int> result(q, -1);
        for (int i = 0; i < q; ++i) {
            int x = queries[i][0];
            int y = queries[i][1];
            for (int j = 0; j < n; ++j) {
                if (nums1[j] >= x && nums2[j] >= y) {
                    result[i] = max(result[i], nums1[j] + nums2[j]);
                }
            }
        }

        return result;
    }
};