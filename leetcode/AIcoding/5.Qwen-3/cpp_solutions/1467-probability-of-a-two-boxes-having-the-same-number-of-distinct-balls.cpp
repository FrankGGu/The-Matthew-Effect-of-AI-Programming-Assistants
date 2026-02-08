#include <iostream>
#include <vector>
#include <map>
#include <cmath>

using namespace std;

class Solution {
public:
    double fact(int n) {
        return (n == 0) ? 1 : n * fact(n - 1);
    }

    double comb(int n, int k) {
        return fact(n) / (fact(k) * fact(n - k));
    }

    double dfs(vector<int>& balls, int idx, int cnt, int total) {
        if (idx == balls.size()) {
            return (cnt == 0) ? 1.0 : 0.0;
        }
        double res = 0.0;
        for (int i = 0; i <= balls[idx]; ++i) {
            int left = i;
            int right = balls[idx] - i;
            if (left > 0) {
                res += dfs(balls, idx + 1, cnt + 1, total + left);
            }
            if (right > 0) {
                res += dfs(balls, idx + 1, cnt - 1, total + right);
            }
        }
        return res;
    }

    double getProbability(vector<int>& balls) {
        int totalBalls = 0;
        for (int b : balls) totalBalls += b;
        return dfs(balls, 0, 0, 0) / fact(totalBalls);
    }
};