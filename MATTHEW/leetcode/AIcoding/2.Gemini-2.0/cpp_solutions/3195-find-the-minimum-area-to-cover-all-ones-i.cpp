#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minArea(vector<vector<char>>& image, int x, int y) {
        int m = image.size();
        int n = image[0].size();

        int left = searchLeft(image, 0, y, 0, x, m, n);
        int right = searchRight(image, y + 1, n, 0, x, m, n);
        int top = searchTop(image, 0, x, left, right, m, n);
        int bottom = searchBottom(image, x + 1, m, left, right, m, n);

        return (right - left) * (bottom - top);
    }

private:
    int searchLeft(vector<vector<char>>& image, int low, int high, int i, int j, int m, int n) {
        while (low < high) {
            int mid = low + (high - low) / 2;
            bool hasOne = false;
            for (int k = 0; k < m; ++k) {
                if (image[k][mid] == '1') {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return low;
    }

    int searchRight(vector<vector<char>>& image, int low, int high, int i, int j, int m, int n) {
        while (low < high) {
            int mid = low + (high - low) / 2;
            bool hasOne = false;
            for (int k = 0; k < m; ++k) {
                if (image[k][mid] == '1') {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    int searchTop(vector<vector<char>>& image, int low, int high, int left, int right, int m, int n) {
        while (low < high) {
            int mid = low + (high - low) / 2;
            bool hasOne = false;
            for (int k = left; k < right; ++k) {
                if (image[mid][k] == '1') {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return low;
    }

    int searchBottom(vector<vector<char>>& image, int low, int high, int left, int right, int m, int n) {
        while (low < high) {
            int mid = low + (high - low) / 2;
            bool hasOne = false;
            for (int k = left; k < right; ++k) {
                if (image[mid][k] == '1') {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
};