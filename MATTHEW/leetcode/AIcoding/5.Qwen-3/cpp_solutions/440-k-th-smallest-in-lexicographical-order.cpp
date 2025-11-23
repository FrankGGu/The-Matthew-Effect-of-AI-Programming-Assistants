#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findKthNumber(int n, int k) {
        long long current = 1;
        k--;
        while (k > 0) {
            long long steps = 0;
            long long first = current;
            long long last = current + 1;
            while (first <= n) {
                steps += min(n + 1, last) - first;
                first *= 10;
                last *= 10;
            }
            if (k >= steps) {
                k -= steps;
                current++;
            } else {
                k--;
                current *= 10;
            }
        }
        return current;
    }
};