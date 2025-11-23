#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minArea(vector<vector<int>>& image, int x, int y) {
        int m = image.size();
        int n = image[0].size();

        int left = findLeft(image, 0, y, 0, m);
        int right = findRight(image, y + 1, n, 0, m);
        int top = findTop(image, 0, x, left, right);
        int bottom = findBottom(image, x + 1, m, left, right);

        return (right - left) * (bottom - top);
    }

private:
    int findLeft(vector<vector<int>>& image, int start, int end, int top, int bottom) {
        while (start < end) {
            int mid = start + (end - start) / 2;
            bool hasOne = false;
            for (int i = top; i < bottom; ++i) {
                if (image[i][mid] == 1) {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne) {
                end = mid;
            } else {
                start = mid + 1;
            }
        }
        return start;
    }

    int findRight(vector<vector<int>>& image, int start, int end, int top, int bottom) {
        while (start < end) {
            int mid = start + (end - start) / 2;
            bool hasOne = false;
            for (int i = top; i < bottom; ++i) {
                if (image[i][mid] == 1) {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne) {
                start = mid + 1;
            } else {
                end = mid;
            }
        }
        return start;
    }

    int findTop(vector<vector<int>>& image, int start, int end, int left, int right) {
        while (start < end) {
            int mid = start + (end - start) / 2;
            bool hasOne = false;
            for (int j = left; j < right; ++j) {
                if (image[mid][j] == 1) {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne) {
                end = mid;
            } else {
                start = mid + 1;
            }
        }
        return start;
    }

    int findBottom(vector<vector<int>>& image, int start, int end, int left, int right) {
        while (start < end) {
            int mid = start + (end - start) / 2;
            bool hasOne = false;
            for (int j = left; j < right; ++j) {
                if (image[mid][j] == 1) {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne) {
                start = mid + 1;
            } else {
                end = mid;
            }
        }
        return start;
    }
};