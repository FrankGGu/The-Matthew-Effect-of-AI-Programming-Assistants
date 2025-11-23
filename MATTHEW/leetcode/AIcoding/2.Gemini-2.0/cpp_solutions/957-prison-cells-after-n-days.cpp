#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> prisonAfterNDays(vector<int>& cells, int n) {
        unordered_map<string, int> seen;
        int period = 0;
        for (int i = 0; i < n; ++i) {
            string state = "";
            for (int cell : cells) {
                state += to_string(cell);
            }
            if (seen.count(state)) {
                period = i - seen[state];
                n %= period;
                break;
            }
            seen[state] = i;

            vector<int> next_cells(cells.size());
            for (int j = 1; j < cells.size() - 1; ++j) {
                next_cells[j] = (cells[j - 1] == cells[j + 1]) ? 1 : 0;
            }
            cells = next_cells;
        }
        return cells;
    }
};