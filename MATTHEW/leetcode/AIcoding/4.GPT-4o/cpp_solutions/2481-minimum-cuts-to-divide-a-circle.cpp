class Solution {
public:
    int minCuts(int n) {
        if (n <= 2) return 0;
        return n - 1;
    }
};