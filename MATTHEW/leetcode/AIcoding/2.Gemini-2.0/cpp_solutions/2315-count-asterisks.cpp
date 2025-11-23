class Solution {
public:
    int countAsterisks(string s) {
        int count = 0;
        bool inside = false;
        for (char c : s) {
            if (c == '|') {
                inside = !inside;
            } else if (c == '*' && !inside) {
                count++;
            }
        }
        return count;
    }
};