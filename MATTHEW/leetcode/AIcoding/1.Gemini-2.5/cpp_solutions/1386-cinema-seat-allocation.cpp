class Solution {
public:
    int maxNumberOfFamilies(int n, vector<vector<int>>& reservedSeats) {
        unordered_map<int, int> rows;
        for (auto& seat : reservedSeats) {
            int row = seat[0];
            int col = seat[1];
            if (col >= 2 && col <= 9) {
                rows[row] |= (1 << (col - 2));
            }
        }

        int count = 0;
        for (int i = 1; i <= n; ++i) {
            if (rows.find(i) == rows.end()) {
                count += 2;
            } else {
                int reserved = rows[i];
                bool left = (reserved & 0b11110000) == 0;
                bool right = (reserved & 0b00001111) == 0;
                bool middle = (reserved & 0b00111100) == 0;

                if (left) count++;
                if (right) count++;
                if (middle && !left && !right) count++;
            }
        }
        return count;
    }
};