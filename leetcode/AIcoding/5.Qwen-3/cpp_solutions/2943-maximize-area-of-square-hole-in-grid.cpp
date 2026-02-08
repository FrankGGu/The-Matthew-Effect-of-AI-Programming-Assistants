#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumSquareArea(int n, vector<int>& xCoordinates, vector<int>& yCoordinates) {
        sort(xCoordinates.begin(), xCoordinates.end());
        sort(yCoordinates.begin(), yCoordinates.end());

        int maxSide = 0;
        for (int i = 1; i < n; ++i) {
            int dx = xCoordinates[i] - xCoordinates[i - 1];
            int dy = yCoordinates[i] - yCoordinates[i - 1];
            maxSide = max(maxSide, min(dx, dy));
        }

        return maxSide * maxSide;
    }
};