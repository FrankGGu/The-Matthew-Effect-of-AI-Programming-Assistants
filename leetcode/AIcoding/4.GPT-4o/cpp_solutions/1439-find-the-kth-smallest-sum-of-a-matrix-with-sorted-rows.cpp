#include <vector>
#include <queue>
#include <tuple>
#include <algorithm>

using namespace std;

class Solution {
public:
    int kthSmallest(vector<vector<int>>& mat, int k) {
        int n = mat.size(), m = mat[0].size();
        priority_queue<pair<int, vector<int>>, vector<pair<int, vector<int>>>, greater<pair<int, vector<int>>>> pq;
        pq.push({0, vector<int>(n, 0)});

        set<vector<int>> visited;
        visited.insert(vector<int>(n, 0));

        for (int i = 0; i < k; ++i) {
            auto [curr_sum, indices] = pq.top();
            pq.pop();

            if (i == k - 1) return curr_sum;

            for (int j = 0; j < n; ++j) {
                if (indices[j] + 1 < m) {
                    vector<int> new_indices = indices;
                    new_indices[j]++;
                    int new_sum = curr_sum - mat[j][indices[j]] + mat[j][new_indices[j]];

                    if (visited.insert(new_indices).second) {
                        pq.push({new_sum, new_indices});
                    }
                }
            }
        }

        return -1; // This line will never be reached
    }
};