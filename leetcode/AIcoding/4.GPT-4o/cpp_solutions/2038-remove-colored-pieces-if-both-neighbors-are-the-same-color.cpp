class Solution {
public:
    bool winnerOfGame(string colors) {
        int aCount = 0, bCount = 0;
        for (int i = 1; i < colors.size() - 1; i++) {
            if (colors[i] == 'A' && colors[i - 1] == 'A' && colors[i + 1] == 'A') {
                aCount++;
            }
            if (colors[i] == 'B' && colors[i - 1] == 'B' && colors[i + 1] == 'B') {
                bCount++;
            }
        }
        return aCount > bCount;
    }
};