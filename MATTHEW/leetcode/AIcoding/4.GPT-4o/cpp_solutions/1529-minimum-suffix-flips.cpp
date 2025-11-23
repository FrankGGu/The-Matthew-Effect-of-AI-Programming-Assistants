class Solution {
public:
    int minFlips(string target) {
        int flips = 0;
        char current = '0';
        for (char c : target) {
            if (c != current) {
                flips++;
                current = c;
            }
        }
        return flips;
    }
};