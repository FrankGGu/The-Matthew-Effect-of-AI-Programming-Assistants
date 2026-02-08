#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maxScoreSubarrayQueries(vector<int>& nums1, vector<int>& nums2, vector<vector<int>>& queries) {
        int n = nums1.size();
        int q = queries.size();
        vector<int> res(q);
        vector<pair<int, int>> sortedQueries(q);
        for (int i = 0; i < q; ++i) {
            sortedQueries[i] = {queries[i][0], i};
        }
        sort(sortedQueries.begin(), sortedQueries.end());

        vector<pair<int, int>> sortedNums2(n);
        for (int i = 0; i < n; ++i) {
            sortedNums2[i] = {nums2[i], i};
        }
        sort(sortedNums2.rbegin(), sortedNums2.rend());

        vector<int> parent(n);
        vector<long long> sum(n, 0);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
            sum[i] = 0;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] == x) {
                return x;
            }
            return parent[x] = find(parent[x]);
        };

        function<void(int, int)> unite = [&](int x, int y) {
            x = find(x);
            y = find(y);
            if (x != y) {
                parent[x] = y;
                sum[y] += sum[x];
            }
        };

        int j = 0;
        for (int i = 0; i < q; ++i) {
            int threshold = sortedQueries[i].first;
            int queryIndex = sortedQueries[i].second;

            while (j < n && sortedNums2[j].first >= threshold) {
                int index = sortedNums2[j].second;
                sum[index] = nums1[index];
                if (index > 0 && nums2[index - 1] >= 0) {
                    if (nums2[index - 1] >= threshold)
                        unite(index, index - 1);
                }
                if (index < n - 1 && nums2[index + 1] >= 0) {
                    if (nums2[index + 1] >= threshold)
                        unite(index, index + 1);
                }
                j++;
            }

            long long maxSum = 0;
            for (int k = 0; k < n; k++) {
                if (nums2[k] >= threshold) {
                    maxSum = sum[find(k)];
                    break;
                }
            }

            res[queryIndex] = maxSum;
        }

        return res;
    }
};