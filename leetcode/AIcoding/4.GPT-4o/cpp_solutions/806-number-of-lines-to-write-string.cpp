class Solution {
public:
    vector<int> numberOfLines(vector<int>& widths, string s) {
        int lines = 1, currentWidth = 0;
        for (char c : s) {
            int width = widths[c - 'a'];
            currentWidth += width;
            if (currentWidth > 100) {
                lines++;
                currentWidth = width;
            }
        }
        return {lines, currentWidth};
    }
};