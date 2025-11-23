class Solution {
public:
    vector<int> prisonAfterNDays(vector<int>& cells, int N) {
        unordered_map<string, int> seen;
        for (int i = 0; i < N; ++i) {
            string s(cells.begin(), cells.end());
            if (seen.find(s) != seen.end()) {
                int loop_len = i - seen[s];
                int remaining = (N - i) % loop_len;
                return prisonAfterNDays(cells, remaining);
            } else {
                seen[s] = i;
                int prev = cells[0];
                for (int j = 1; j < 7; ++j) {
                    int curr = cells[j];
                    int next = cells[j+1];
                    cells[j] = prev == next;
                    prev = curr;
                }
            }
            cells[0] = 0;
            cells[7] = 0;
        }
        return cells;
    }
};