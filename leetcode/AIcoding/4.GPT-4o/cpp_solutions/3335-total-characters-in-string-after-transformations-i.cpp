class Solution {
public:
    int transformedStringLength(string s) {
        int totalLength = 0;
        for (char c : s) {
            if (c == 'a' || c == 'b' || c == 'c') {
                totalLength += 2;
            } else {
                totalLength += 1;
            }
        }
        return totalLength;
    }
};