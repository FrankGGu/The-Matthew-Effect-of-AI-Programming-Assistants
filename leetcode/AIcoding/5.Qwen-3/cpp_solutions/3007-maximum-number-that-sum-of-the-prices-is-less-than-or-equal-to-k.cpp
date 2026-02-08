#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    long long maxNumberWithMaxPrice(long long k) {
        long long res = 0;
        long long price = 0;
        long long i = 1;
        while (price <= k) {
            long long cnt = 0;
            long long temp = i;
            while (temp > 0) {
                if (temp % 10 != 0) {
                    cnt++;
                }
                temp /= 10;
            }
            price += cnt;
            if (price > k) break;
            res = i;
            i++;
        }
        return res;
    }

    long long findMaximumNumber(long long k) {
        long long low = 1, high = 1e18;
        long long ans = 0;
        while (low <= high) {
            long long mid = (low + high) / 2;
            long long price = 0;
            long long num = mid;
            while (num > 0) {
                if (num % 10 != 0) {
                    price += 1;
                }
                num /= 10;
            }
            if (price <= k) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    long long findMaximumNumber(long long k, long long n) {
        return findMaximumNumber(k);
    }
};