#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> constructRectangle(int area) {
        int width = sqrt(area);
        while (area % width != 0) {
            width--;
        }
        return {area / width, width};
    }
};