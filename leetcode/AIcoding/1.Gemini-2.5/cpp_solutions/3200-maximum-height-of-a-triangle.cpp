#include <algorithm> // Required for std::max

class Solution {
public:
    int calculate_height(int r, int b, bool start_with_red) {
        int current_red = r;
        int current_blue = b;
        int height = 0;
        int i = 1;

        while (true) {
            if (start_with_red) {
                if (i % 2 != 0) { // Odd row needs red
                    if (current_red >= i) {
                        current_red -= i;
                        height++;
                        i++;
                    } else {
                        break;
                    }
                } else { // Even row needs blue
                    if (current_blue >= i) {
                        current_blue -= i;
                        height++;
                        i++;
                    } else {
                        break;
                    }
                }
            } else { // Start with blue
                if (i % 2 != 0) { // Odd row needs blue
                    if (current_blue >= i) {
                        current_blue -= i;
                        height++;
                        i++;
                    } else {
                        break;
                    }
                } else { // Even row needs red
                    if (current_red >= i) {
                        current_red -= i;
                        height++;
                        i++;
                    } else {
                        break;
                    }
                }
            }
        }
        return height;
    }

    int maxHeightOfTriangle(int red, int blue) {
        return std::max(calculate_height(red, blue, true), calculate_height(red, blue, false));
    }
};