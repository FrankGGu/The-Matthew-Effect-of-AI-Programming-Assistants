#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
public:
    int getNumberOfValidMoves(int x, int y) {
        vector<vector<int>> directions = {{1, 2}, {2, 1}, {-1, 2}, {-2, 1},
                                           {-1, -2}, {-2, -1}, {1, -2}, {2, -1}};
        int count = 0;
        for (const auto& dir : directions) {
            int nx = x + dir[0];
            int ny = y + dir[1];
            if (nx >= 0 && nx < 8 && ny >= 0 && ny < 8) {
                count++;
            }
        }
        return count;
    }

    int countMoves(int x, int y, vector<vector<int>>& visited, vector<vector<int>>& knightMoves) {
        int moves = 0;
        for (int i = 0; i < 8; ++i) {
            int nx = x + knightMoves[i][0];
            int ny = y + knightMoves[i][1];
            if (nx >= 0 && nx < 8 && ny >= 0 && ny < 8 && !visited[nx][ny]) {
                visited[nx][ny] = 1;
                moves += 1 + countMoves(nx, ny, visited, knightMoves);
                visited[nx][ny] = 0;
            }
        }
        return moves;
    }

    int countCombinations() {
        vector<vector<int>> knightMoves = {{1, 2}, {2, 1}, {-1, 2}, {-2, 1},
                                           {-1, -2}, {-2, -1}, {1, -2}, {2, -1}};
        int total = 0;
        for (int x = 0; x < 8; ++x) {
            for (int y = 0; y < 8; ++y) {
                vector<vector<int>> visited(8, vector<int>(8, 0));
                visited[x][y] = 1;
                total += 1 + countMoves(x, y, visited, knightMoves);
            }
        }
        return total;
    }

    int numberOfValidMoveCombinations() {
        return countCombinations();
    }
};