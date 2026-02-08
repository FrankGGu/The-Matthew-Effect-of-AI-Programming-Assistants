#include <vector>

using namespace std;

class Solution {
public:
    vector<int> leftmostBuildingQueries(vector<int>& heights, vector<vector<int>>& queries) {
        int n = heights.size();
        int m = queries.size();
        vector<int> ans(m, -1);
        vector<int> idx(m);
        for (int i = 0; i < m; ++i) {
            idx[i] = i;
        }
        sort(idx.begin(), idx.end(), [&](int i, int j) {
            return max(heights[queries[i][0]], heights[queries[i][1]]) < max(heights[queries[j][0]], heights[queries[j][1]]);
        });

        vector<int> stack;
        for (int i : idx) {
            int a = queries[i][0];
            int b = queries[i][1];
            int max_height = max(heights[a], heights[b]);

            if (a > b) swap(a, b);

            stack.clear();
            for (int j = 0; j < n; ++j) {
                if (heights[j] > max_height) {
                    if (j >= a) {
                        if (j <= b) {
                            ans[i] = j;
                            break;
                        } else {
                            ans[i] = j;
                            break;
                        }

                    }
                    else {
                        ans[i] = j;
                        break;
                    }
                }
            }

            if (ans[i] == -1 && heights[a] <= max_height && heights[b] <= max_height) {
                ans[i] = b;
            }

        }

        return ans;
    }
};