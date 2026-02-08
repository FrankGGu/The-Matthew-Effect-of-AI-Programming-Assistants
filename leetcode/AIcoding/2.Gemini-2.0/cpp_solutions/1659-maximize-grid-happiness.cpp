#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getHappiness(int row, int col, int n, int m, int neighbors, int introvertsLeft, int extrovertsLeft, vector<vector<int>>& memo) {
        if (introvertsLeft < 0 || extrovertsLeft < 0) return -1e9;
        if (row == n) return 0;
        if (memo[neighbors][introvertsLeft * (m + 1) + extrovertsLeft] != -1) return memo[neighbors][introvertsLeft * (m + 1) + extrovertsLeft];

        int nextRow = row + (col + 1) / m;
        int nextCol = (col + 1) % m;
        int newNeighbors = (neighbors % (1 << (m - 1))) << 1;

        int maxHappiness = -1e9;

        // Place no one
        maxHappiness = max(maxHappiness, getHappiness(nextRow, nextCol, n, m, newNeighbors, introvertsLeft, extrovertsLeft, memo));

        // Place introvert
        int introvertHappiness = 30;
        if (col > 0 && (neighbors & 1)) introvertHappiness -= 30;
        if (row > 0 && (neighbors & (1 << (m - 1)))) introvertHappiness -= 30;
        maxHappiness = max(maxHappiness, introvertHappiness + getHappiness(nextRow, nextCol, n, m, newNeighbors + 1, introvertsLeft - 1, extrovertsLeft, memo));

        // Place extrovert
        int extrovertHappiness = 20;
        if (col > 0 && (neighbors & 1)) extrovertHappiness += 20;
        if (row > 0 && (neighbors & (1 << (m - 1)))) extrovertHappiness += 20;
        maxHappiness = max(maxHappiness, extrovertHappiness + getHappiness(nextRow, nextCol, n, m, newNeighbors, introvertsLeft, extrovertsLeft - 1, memo));

        return memo[neighbors][introvertsLeft * (m + 1) + extrovertsLeft] = maxHappiness;
    }

    int getMaxGridHappiness(int n, int m, int introvertsCount, int extrovertsCount) {
        vector<vector<int>> memo(1 << m, vector<int>((introvertsCount + 1) * (m + 1) + (extrovertsCount+1), -1));
        return getHappiness(0, 0, n, m, 0, introvertsCount, extrovertsCount, memo);
    }
};