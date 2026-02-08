#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
public:
    int minDays(int n) {
        unordered_map<int, int> memo;
        return dfs(n, memo);
    }

private:
    int dfs(int n, unordered_map<int, int>& memo) {
        if (n <= 1) return n;
        if (memo.count(n)) return memo[n];
        int option1 = 1 + n % 2 + dfs(n / 2, memo);
        int option2 = 1 + n % 3 + dfs(n / 3, memo);
        memo[n] = min(option1, option2);
        return memo[n];
    }
};