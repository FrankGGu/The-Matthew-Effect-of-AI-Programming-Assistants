class Solution {
public:
    int findMinFibonacciNumbers(int k) {
        vector<int> fib = {1, 2};
        while (fib.back() < k) {
            fib.push_back(fib[fib.size() - 1] + fib[fib.size() - 2]);
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