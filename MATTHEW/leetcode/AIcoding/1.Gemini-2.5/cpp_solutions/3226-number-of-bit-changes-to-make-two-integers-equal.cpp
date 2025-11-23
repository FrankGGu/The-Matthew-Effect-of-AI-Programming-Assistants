class Solution {
public:
    int minChanges(int n, int k) {
        return __builtin_popcount(n ^ k);
    }
};