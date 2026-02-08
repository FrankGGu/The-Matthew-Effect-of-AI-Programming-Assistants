#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    string smallestGoodBase(int n) {
        long long N = n;
        for (long long k = 60; k >= 2; --k) {
            long long low = 2;
            long long high = (long long)pow(N, 1.0 / k) + 1;
            while (low <= high) {
                long long mid = (low + high) / 2;
                long long sum = 0;
                long long cur = 1;
                for (int i = 0; i < k; ++i) {
                    sum += cur;
                    cur *= mid;
                    if (sum > N) break;
                }
                if (sum == N) return to_string(mid);
                else if (sum < N) low = mid + 1;
                else high = mid - 1;
            }
        }
        return to_string(N);
    }
};