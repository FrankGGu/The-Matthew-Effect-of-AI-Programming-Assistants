#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int k;
    int count = 0;

    int numberOfSubarrays(vector<int>& nums, int k) {
        this->k = k;
        int result = 0;
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;
        int prefixSum = 0;

        for (int num : nums) {
            prefixSum += num % 2;
            if (prefixSum >= k && prefixCount.find(prefixSum - k) != prefixCount.end()) {
                result += prefixCount[prefixSum - k];
            }
            prefixCount[prefixSum]++;
        }

        return result;
    }

    int dfs(TreeNode* node, int& total, int k) {
        if (!node) return 0;
        int left = dfs(node->left, total, k);
        int right = dfs(node->right, total, k);
        int sum = left + right + node->val;
        if (sum % k == 0) total++;
        return sum;
    }

    int largestComponentSize(vector<int>& nums) {
        int maxNum = *max_element(nums.begin(), nums.end());
        vector<int> parent(maxNum + 1);
        for (int i = 0; i <= maxNum; ++i) parent[i] = i;

        function<int(int)> find = [&](int x) {
            return parent[x] == x ? x : parent[x] = find(parent[x]);
        };

        function<void(int, int)> unionSet = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) parent[rootY] = rootX;
        };

        for (int num : nums) {
            for (int i = 2; i * i <= num; ++i) {
                if (num % i == 0) {
                    unionSet(num, i);
                    while (num % i == 0) num /= i;
                }
            }
            if (num > 1) unionSet(num, num);
        }

        unordered_map<int, int> freq;
        for (int num : nums) {
            int root = find(num);
            freq[root]++;
        }

        int maxFreq = 0;
        for (auto& [_, f] : freq) {
            maxFreq = max(maxFreq, f);
        }

        return maxFreq;
    }

    int maxKDivisibleComponents(vector<int>& nums, vector<vector<int>>& edges, int k) {
        int n = nums.size();
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int total = 0;
        dfs(nullptr, total, k);
        return total;
    }

    int dfs(TreeNode* node, int& total, int k) {
        if (!node) return 0;
        int left = dfs(node->left, total, k);
        int right = dfs(node->right, total, k);
        int sum = left + right + node->val;
        if (sum % k == 0) total++;
        return sum;
    }
};