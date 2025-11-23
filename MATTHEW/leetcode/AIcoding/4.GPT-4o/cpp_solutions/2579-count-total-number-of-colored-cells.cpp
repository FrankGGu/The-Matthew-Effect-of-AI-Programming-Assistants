class Solution {
public:
    int countColoredCells(int n) {
        return n * n + (n - 1) * (n - 1);
    }
};