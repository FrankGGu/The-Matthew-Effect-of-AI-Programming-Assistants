#include <vector>
#include <algorithm>

class Solution {
public:
    int findMinFibonacciNumbers(int k) {
        std::vector<int> fib;
        fib.push_back(1);
        fib.push_back(1);

        while (fib.back() <= k) {
            int next_fib = fib[fib.size() - 1] + fib[fib.size() - 2];
            if (next_fib > k) {
                break;
            }
            fib.push_back(next_fib);
        }

        int count = 0;
        for (int i = fib.size() - 1; i >= 0 && k > 0; --i) {
            if (fib[i] <= k) {
                k -= fib[i];
                count++;
            }
        }

        return count;
    }
};