class Solution {
public:
    long long manhattanDistance(int n) {
        return static_cast<long long>(n) * (n - 1) * (n + 1) / 6;
    }
};