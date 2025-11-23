class Solution {
public:
    vector<int> prisonAfterNDays(vector<int>& cells, int N) {
        vector<int> result(8);
        unordered_map<string, int> seen;
        int cycleLength = 0;

        while (N > 0) {
            string state = "";
            for (int i = 0; i < 8; ++i) {
                state += to_string(cells[i]);
            }
            if (seen.count(state)) {
                cycleLength = seen[state] - N;
                N %= cycleLength;
            } else {
                seen[state] = N;
            }

            if (N == 0) break;

            vector<int> next(8);
            for (int i = 1; i < 7; ++i) {
                next[i] = cells[i - 1] == cells[i + 1] ? 1 : 0;
            }
            cells = next;
            --N;
        }

        return cells;
    }
};