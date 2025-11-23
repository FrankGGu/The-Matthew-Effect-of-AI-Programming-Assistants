#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> missingRolls(vector<int>& rolls, int mean, int n) {
        int m = rolls.size();
        long total = 0;
        for (int roll : rolls) {
            total += roll;
        }
        long required = static_cast<long>(mean) * (n + m);
        long missing = required - total;
        if (missing <= 0 || missing < n || missing > 6 * n) {
            return {};
        }
        vector<int> result(n, 1);
        missing -= n;
        for (int i = 0; i < n && missing > 0; ++i) {
            int add = min(5, missing);
            result[i] += add;
            missing -= add;
        }
        return result;
    }
};