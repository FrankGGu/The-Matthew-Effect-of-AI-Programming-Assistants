class Solution {
public:
    bool squareIsWhite(std::string coordinates) {
        int col = coordinates[0] - 'a' + 1;
        int row = coordinates[1] - '0';

        if ((col + row) % 2 == 0) {
            return false; // Even sum means black (like a1)
        } else {
            return true;  // Odd sum means white
        }
    }
};