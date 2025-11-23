class Solution {
public:
    int maxNumberOfFamilies(int n, vector<vector<int>>& reservedSeats) {
        unordered_map<int, int> seats;
        for (const auto& seat : reservedSeats) {
            int row = seat[0];
            int col = seat[1];
            seats[row] |= (1 << (col - 1));
        }

        int res = 2 * (n - seats.size());
        for (const auto& [row, mask] : seats) {
            bool left = (mask & 0b0111111110) == 0;
            bool right = (mask & 0b0000011110) == 0;
            bool mid = (mask & 0b0001111000) == 0;
            if (left && right) {
                res += 2;
            } else if (left || right || mid) {
                res += 1;
            }
        }
        return res;
    }
};