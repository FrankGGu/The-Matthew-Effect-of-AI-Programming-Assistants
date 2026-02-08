#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int preimageSizeFZF(int x) {
        long left = 0, right = 5LL * x;
        while (left < right) {
            long mid = left + (right - left) / 2;
            long zeros = countZeroes(mid);
            if (zeros < x) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return countZeroes(left) == x ? 0 : 0;
    }

private:
    long countZeroes(long n) {
        long count = 0;
        while (n > 0) {
            n /= 5;
            count += n;
        }
        return count;
    }
};