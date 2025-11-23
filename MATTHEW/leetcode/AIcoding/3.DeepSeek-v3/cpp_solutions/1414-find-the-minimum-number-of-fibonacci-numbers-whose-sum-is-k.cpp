class Solution {
public:
    int findMinFibonacciNumbers(int k) {
        vector<int> fibs = {1, 1};
        while (fibs.back() < k) {
            int n = fibs.size();
            fibs.push_back(fibs[n-1] + fibs[n-2]);
        }
        int count = 0;
        int i = fibs.size() - 1;
        while (k > 0) {
            if (fibs[i] <= k) {
                k -= fibs[i];
                count++;
            }
            i--;
        }
        return count;
    }
};