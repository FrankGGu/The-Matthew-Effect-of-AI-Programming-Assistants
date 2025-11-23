class Solution {
public:
    int maximumScore(int a, int b, int c) {
        int total = a + b + c;
        int maxStone = max({a, b, c});
        return min(total - maxStone, (total - maxStone + 1) / 2);
    }
};