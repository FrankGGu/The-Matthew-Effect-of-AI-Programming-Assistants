#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    long long minimumTime(int n, vector<int>& time) {
        long long left = 0;
        long long right = *max_element(time.begin(), time.end()) * (long long)n;

        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long total = 0;
            for (int t : time) {
                total += mid / t;
                if (total >= n) break;
            }
            if (total >= n) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
};