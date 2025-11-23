#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    double soupServings(int n) {
        if (n >= 5000) return 1.0;
        unordered_map<int, double> memo;
        return dfs(n, n, memo);
    }

private:
    double dfs(int a, int b, unordered_map<int, double>& memo) {
        if (a <= 0 && b <= 0) return 0.5;
        if (a <= 0) return 1.0;
        if (b <= 0) return 0.0;
        int key = a * 10000 + b;
        if (memo.count(key)) return memo[key];
        double result = 0.25 * dfs(a - 100, b - 0, memo);
        result += 0.25 * dfs(a - 75, b - 25, memo);
        result += 0.25 * dfs(a - 50, b - 50, memo);
        result += 0.25 * dfs(a - 25, b - 75, memo);
        memo[key] = result;
        return result;
    }
};