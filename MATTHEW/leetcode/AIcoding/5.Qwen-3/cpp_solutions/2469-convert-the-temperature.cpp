#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<double> convertTemperature(double celsius) {
        double kelvin = celsius + 273.15;
        double fahrenheit = celsius * 9.0 / 5.0 + 32.0;
        return {kelvin, fahrenheit};
    }
};