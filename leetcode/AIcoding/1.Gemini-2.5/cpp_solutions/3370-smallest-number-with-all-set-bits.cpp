class Solution {
public:
    long long smallestNumberWithAllSetBits(int n) {
        return (1LL << n) - 1;
    }
};