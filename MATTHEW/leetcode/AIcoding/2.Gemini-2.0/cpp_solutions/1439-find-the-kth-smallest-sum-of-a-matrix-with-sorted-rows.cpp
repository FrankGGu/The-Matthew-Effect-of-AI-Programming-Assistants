#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int kthSmallest(vector<vector<int>>& mat, int k) {
        int m = mat.size();
        int n = mat[0].size();

        priority_queue<pair<int, vector<int>>, vector<pair<int, vector<int>>>, greater<pair<int, vector<int>>>> pq;
        pq.push({0, vector<int>(m, 0)});

        vector<vector<int>> visited;
        visited.push_back(vector<int>(m, 0));

        for (int count = 0; count < k; ++count) {
            auto current = pq.top();
            pq.pop();
            int sum = current.first;
            vector<int> indices = current.second;

            if (count == k - 1) {
                return sum;
            }

            for (int i = 0; i < m; ++i) {
                if (indices[i] + 1 < n) {
                    vector<int> next_indices = indices;
                    next_indices[i]++;

                    bool isVisited = false;
                    for(const auto& v : visited) {
                        if(v == next_indices) {
                            isVisited = true;
                            break;
                        }
                    }

                    if (!isVisited) {
                        int next_sum = sum - mat[i][indices[i]] + mat[i][next_indices[i]];
                        pq.push({next_sum, next_indices});
                        visited.push_back(next_indices);
                    }
                }
            }
        }

        return -1;
    }
};