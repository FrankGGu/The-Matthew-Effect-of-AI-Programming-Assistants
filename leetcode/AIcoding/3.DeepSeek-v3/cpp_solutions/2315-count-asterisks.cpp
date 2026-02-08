class Solution {
public:
    int countAsterisks(string s) {
        int count = 0;
        bool inPair = false;
        for (char c : s) {
            if (c == '|') {
                inPair = !inPair;
            } else if (c == '*' && !inPair) {
                count++;
            }
        }
        return count;
    }
};