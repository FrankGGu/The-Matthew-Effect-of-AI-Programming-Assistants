class Solution {
public:
    int findKthNumber(int n, int k) {
        int curr = 1;
        k--;
        while (k > 0) {
            long steps = 0, first = curr, last = curr + 1;
            while (first <= n) {
                steps += min((long)n + 1, last) - first;
                first *= 10;
                last *= 10;
            }
            if (steps <= k) {
                curr++;
                k -= steps;
            } else {
                curr *= 10;
                k--;
            }
        }
        return curr;
    }
};