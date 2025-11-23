class Solution {
public:
    int minArea(vector<vector<char>>& image, int x, int y) {
        int m = image.size(), n = image[0].size();
        int left = y, right = y, top = x, bottom = x;

        while (left > 0 && hasBlackPixel(image, x, left - 1)) left--;
        while (right < n - 1 && hasBlackPixel(image, x, right + 1)) right++;
        while (top > 0 && hasBlackPixelCol(image, top - 1, left, right)) top--;
        while (bottom < m - 1 && hasBlackPixelCol(image, bottom + 1, left, right)) bottom++;

        return (right - left + 1) * (bottom - top + 1);
    }

private:
    bool hasBlackPixel(vector<vector<char>>& image, int row) {
        for (char c : image[row]) {
            if (c == '1') return true;
        }
        return false;
    }

    bool hasBlackPixelCol(vector<vector<char>>& image, int col, int left, int right) {
        for (int i = left; i <= right; i++) {
            if (image[i][col] == '1') return true;
        }
        return false;
    }
};