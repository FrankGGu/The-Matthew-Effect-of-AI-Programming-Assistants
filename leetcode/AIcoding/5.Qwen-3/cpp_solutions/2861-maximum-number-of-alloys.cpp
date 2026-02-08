#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    long long maxNumberOfAlloys(int n, int k, vector<int>& budget, vector<int>& prices, vector<int>& required) {
        long long left = 0;
        long long right = 0;
        for (int i = 0; i < n; ++i) {
            right = max(right, (long long)(budget[i] / prices[i]));
        }

        while (left < right) {
            long long mid = (left + right + 1) / 2;
            long long total = 0;
            for (int i = 0; i < n; ++i) {
                total += (long long)required[i] * prices[i] * mid;
                if (total > budget[i]) {
                    break;
                }
            }
            if (total <= 0) {
                return 0;
            }
            if (total <= budget[0]) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }
};