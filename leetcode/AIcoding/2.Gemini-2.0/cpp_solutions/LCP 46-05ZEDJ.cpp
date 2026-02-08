#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int volunteerDeployment(vector<int>& finalCnt, long long totalNum, vector<vector<int>>& edges, vector<int>& addition) {
        int n = finalCnt.size();
        vector<vector<int>> adj(n + 1);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        long long sum = 0;
        for (int i = 0; i < n; ++i) {
            sum += finalCnt[i];
        }

        long long coeff = 1 + adj[0].size();
        long long constTerm = 0;
        for (int i = 1; i <= n; ++i) {
            if (i - 1 < addition.size()) {
                constTerm += addition[i - 1];
                sum -= addition[i - 1];
                constTerm += adj[i].size() * addition[i - 1];
            }
        }

        long long x = (totalNum - sum + constTerm) / coeff;
        return x;
    }
};