#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    string categorizeBox(double length, double width, double height, int mass) {
        bool isHeavy = mass >= 100;
        bool isBulky = (length >= 1e4 || width >= 1e4 || height >= 1e4) || (length * width * height >= 1e9);

        if (isHeavy && isBulky) {
            return "Both";
        } else if (isHeavy) {
            return "Heavy";
        } else if (isBulky) {
            return "Bulky";
        } else {
            return "Neither";
        }
    }
};