#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> prisonAfterNDays(vector<int>& cells, int N) {
        unordered_map<int, vector<int>> seen;
        int day = 0;
        while (day < N) {
            vector<int> next_cells(8, 0);
            for (int i = 1; i < 7; ++i) {
                if (cells[i - 1] == cells[i + 1]) {
                    next_cells[i] = 1;
                }
            }
            int key = 0;
            for (int cell : next_cells) {
                key = key * 2 + cell;
            }
            if (seen.find(key) != seen.end()) {
                int cycle = day - seen[key];
                N = (N - day) % cycle;
                day = N;
                break;
            } else {
                seen[key] = next_cells;
                cells = next_cells;
                ++day;
            }
        }
        return cells;
    }
};