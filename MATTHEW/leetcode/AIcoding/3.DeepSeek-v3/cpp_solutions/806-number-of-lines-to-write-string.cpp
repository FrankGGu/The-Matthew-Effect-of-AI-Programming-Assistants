class Solution {
public:
    vector<int> numberOfLines(vector<int>& widths, string s) {
        int lines = 1;
        int currentWidth = 0;
        for (char c : s) {
            int width = widths[c - 'a'];
            if (currentWidth + width > 100) {
                lines++;
                currentWidth = width;
            } else {
                currentWidth += width;
            }
        }
        return {lines, currentWidth};
    }
};