#include <vector>
#include <algorithm>
#include <cmath>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numSquarefulPerms(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        vector<int> uniqueNums;
        for (auto const& [num, freq] : count) {
            uniqueNums.push_back(num);
        }

        unordered_map<int, vector<int>> adj;
        for (int i = 0; i < uniqueNums.size(); ++i) {
            for (int j = i + 1; j < uniqueNums.size(); ++j) {
                int sum = uniqueNums[i] + uniqueNums[j];
                int root = sqrt(sum);
                if (root * root == sum) {
                    adj[uniqueNums[i]].push_back(uniqueNums[j]);
                    adj[uniqueNums[j]].push_back(uniqueNums[i]);
                }
            }
        }

        long long totalPerms = 0;
        for (int startNode : uniqueNums) {
            unordered_map<int, int> currentCount = count;
            currentCount[startNode]--;
            totalPerms += dfs(startNode, n - 1, currentCount, adj);
        }

        return (int)totalPerms;
    }

private:
    long long dfs(int currentNode, int remainingNodes, unordered_map<int, int>& currentCount, unordered_map<int, vector<int>>& adj) {
        if (remainingNodes == 0) {
            return 1;
        }

        long long perms = 0;
        for (int neighbor : adj[currentNode]) {
            if (currentCount[neighbor] > 0) {
                currentCount[neighbor]--;
                perms += dfs(neighbor, remainingNodes - 1, currentCount, adj);
                currentCount[neighbor]++;
            }
        }

        return perms;
    }
};