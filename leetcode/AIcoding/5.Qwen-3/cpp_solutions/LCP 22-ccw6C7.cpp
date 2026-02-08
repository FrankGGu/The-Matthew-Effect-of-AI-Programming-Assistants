#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int drawLine(int length, int w, int x1, int x2, int y) {
        int row = y;
        int start = x1;
        int end = x2;
        int width = w;
        int result = 0;
        for (int i = 0; i < length; ++i) {
            int bit = 0;
            if (i >= start && i <= end) {
                bit = 1;
            }
            result |= (bit << (width - 1 - i));
        }
        return result;
    }
};