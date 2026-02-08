#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> closestDivisors(int num) {
        vector<int> ans1, ans2;
        int bestDiff1 = INT_MAX;
        int bestDiff2 = INT_MAX;

        int num1 = num + 1;
        for (int i = 1; i <= sqrt(num1); ++i) {
            if (num1 % i == 0) {
                int a = i;
                int b = num1 / i;
                int diff = abs(a - b);
                if (diff < bestDiff1) {
                    bestDiff1 = diff;
                    ans1 = {a, b};
                }
            }
        }

        int num2 = num + 2;
        for (int i = 1; i <= sqrt(num2); ++i) {
            if (num2 % i == 0) {
                int a = i;
                int b = num2 / i;
                int diff = abs(a - b);
                if (diff < bestDiff2) {
                    bestDiff2 = diff;
                    ans2 = {a, b};
                }
            }
        }

        if (bestDiff1 <= bestDiff2) {
            return ans1;
        } else {
            return ans2;
        }
    }
};