#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countRoutes(vector<int>& locations, int start, int finish, int fuel) {
        int n = locations.size();
        vector<vector<int>> dp(n, vector<int>(fuel + 1, -1));
        return dfs(start, finish, fuel, locations, dp);
    }

    int dfs(int i, int finish, int fuel, vector<int>& locations, vector<vector<int>>& dp) {
        if (dp[i][fuel] != -1) return dp[i][fuel];
        int res = (i == finish ? 1 : 0);
        for (int j = 0; j < locations.size(); ++j) {
            if (j != i && fuel >= abs(locations[i] - locations[j])) {
                res += dfs(j, finish, fuel - abs(locations[i] - locations[j]), locations, dp);
            }
        }
        return dp[i][fuel] = res;
    }
};