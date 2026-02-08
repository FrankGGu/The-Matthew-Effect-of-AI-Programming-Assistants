#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    bool checkOverlap(int radius, int xCenter1, int yCenter1, int xCenter2, int yCenter2, int xCorner1, int yCorner1, int xCorner2, int yCorner2) {
        int rectLeft = min(xCorner1, xCorner2);
        int rectRight = max(xCorner1, xCorner2);
        int rectBottom = min(yCorner1, yCorner2);
        int rectTop = max(yCorner1, yCorner2);

        int closestX = max(rectLeft, min(xCenter1, rectRight));
        int closestY = max(rectBottom, min(yCenter1, rectTop));

        int dx = xCenter1 - closestX;
        int dy = yCenter1 - closestY;

        return (dx * dx + dy * dy) <= radius * radius;
    }
};