#include <iostream>
#include <vector>
#include <map>
#include <string>

using namespace std;

class Solution {
public:
    vector<double> convertTemperature(vector<double>& celsius) {
        vector<double> result;
        double kelvin = celsius[0] + 273.15;
        double fahrenheit = celsius[0] * 9.0 / 5.0 + 32.0;
        result.push_back(kelvin);
        result.push_back(fahrenheit);
        return result;
    }
};