class Solution {
public:
    string navigate(string instructions) {
        int x = 0, y = 0;
        for (char c : instructions) {
            if (c == 'U') {
                y++;
            } else if (c == 'D') {
                y--;
            } else if (c == 'L') {
                x--;
            } else if (c == 'R') {
                x++;
            }
        }
        return "Position: (" + to_string(x) + ", " + to_string(y) + ")";
    }
};