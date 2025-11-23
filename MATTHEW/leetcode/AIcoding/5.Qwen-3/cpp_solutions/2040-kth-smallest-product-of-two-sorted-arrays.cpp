#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long kthSmallestProduct(long long n, long long m, long long k, vector<int>& a, vector<int>& b) {
        long long left = -1e10, right = 1e10;

        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long count = 0;

            for (int i = 0; i < n; ++i) {
                if (a[i] > 0) {
                    long long target = (long long)ceil((double)(mid) / a[i]);
                    if (target <= b[m - 1]) {
                        auto it = upper_bound(b.begin(), b.end(), target);
                        count += (it - b.begin());
                    }
                } else if (a[i] < 0) {
                    long long target = (long long)floor((double)(mid) / a[i]);
                    if (target >= b[0]) {
                        auto it = lower_bound(b.begin(), b.end(), target);
                        count += (b.end() - it);
                    }
                } else {
                    if (mid >= 0) count += m;
                }
            }

            if (count >= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }
};