#include <algorithm> // Required for std::min

class Solution {
public:
    long long getSteps(int n, long long curr) {
        long long steps = 0;
        long long first = curr;
        long long next = curr + 1;
        while (first <= n) {
            steps += std::min((long long)n + 1, next) - first;
            first *= 10;
            next *= 10;
        }
        return steps;
    }

    int findKthNumber(int n, int k) {
        long long curr = 1;
        k--; // Adjust k to be 0-indexed offset from curr

        while (k > 0) {
            long long steps = getSteps(n, curr);
            if (k >= steps) {
                k -= steps;
                curr++;
                while (curr % 10 == 0) {
                    curr /= 10;
                }
            } else {
                k--;
                curr *= 10;
            }
        }
        return curr;
    }
};