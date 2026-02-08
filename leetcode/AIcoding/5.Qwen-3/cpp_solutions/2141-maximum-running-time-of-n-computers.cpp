#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxRunTime(int n, vector<int>& batteries) {
        sort(batteries.begin(), batteries.end());
        long long total = 0;
        for (int b : batteries) {
            total += b;
        }
        int m = batteries.size();
        for (int i = m - 1; i >= 0; i--) {
            if (batteries[i] > total / n) {
                total -= batteries[i];
                n--;
            } else {
                break;
            }
        }
        return total / n;
    }
};