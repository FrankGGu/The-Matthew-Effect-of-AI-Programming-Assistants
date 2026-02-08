#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numOfWays(vector<int>& nums) {
        return dfs(nums) - 1;
    }

private:
    int dfs(vector<int>& nums) {
        if (nums.size() <= 1) return 1;
        vector<int> left, right;
        int root = nums[0];
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] < root) left.push_back(nums[i]);
            else right.push_back(nums[i]);
        }
        int leftWays = dfs(left);
        int rightWays = dfs(right);
        int n = nums.size() - 1;
        int k = left.size();
        return comb(n, k) * leftWays * rightWays;
    }

    int comb(int n, int k) {
        long long res = 1;
        for (int i = 0; i < k; ++i) {
            res = res * (n - i) / (i + 1);
        }
        return res;
    }
};