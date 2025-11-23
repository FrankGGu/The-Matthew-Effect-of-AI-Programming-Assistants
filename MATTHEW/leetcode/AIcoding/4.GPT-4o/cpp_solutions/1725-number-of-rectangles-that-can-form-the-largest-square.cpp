class Solution {
public:
    int countGoodRectangles(vector<vector<int>>& rectangles) {
        int maxLength = 0, count = 0;
        for (const auto& rect : rectangles) {
            int squareLength = min(rect[0], rect[1]);
            if (squareLength > maxLength) {
                maxLength = squareLength;
                count = 1;
            } else if (squareLength == maxLength) {
                count++;
            }
        }
        return count;
    }
};