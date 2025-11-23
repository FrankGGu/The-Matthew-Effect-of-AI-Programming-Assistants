#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int removeStones(vector<vector<int>>& stones) {
        unordered_map<int, int> row;
        unordered_map<int, int> col;
        unordered_set<int> visitedRow;
        unordered_set<int> visitedCol;

        for (auto& stone : stones) {
            int r = stone[0], c = stone[1];
            if (row.find(r) == row.end()) {
                row[r] = 0;
            }
            if (col.find(c) == col.end()) {
                col[c] = 0;
            }
            row[r]++;
            col[c]++;
        }

        int count = 0;

        for (auto& stone : stones) {
            int r = stone[0], c = stone[1];
            if (visitedRow.find(r) == visitedRow.end() && visitedCol.find(c) == visitedCol.end()) {
                count++;
                visitedRow.insert(r);
                visitedCol.insert(c);
            }
        }

        return stones.size() - count;
    }
};