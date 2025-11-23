#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> optimalWaterDistribution(int n, vector<int>& wells, vector<vector<int>>& pipes) {
        vector<vector<int>> adj(n + 1);
        for (int i = 0; i < pipes.size(); ++i) {
            adj[pipes[i][0]].push_back(pipes[i][1]);
            adj[pipes[i][1]].push_back(pipes[i][0]);
        }

        vector<int> water(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            water[i] = wells[i - 1];
        }

        return water;
    }
};