#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int comfortableTemperature(vector<int>& temperatures) {
        int count = 0;
        for (int i = 0; i < temperatures.size(); ++i) {
            bool isComfortable = true;
            for (int j = 0; j < temperatures.size(); ++j) {
                if (i != j && abs(temperatures[i] - temperatures[j]) <= 1) {
                    isComfortable = false;
                    break;
                }
            }
            if (isComfortable) {
                ++count;
            }
        }
        return count;
    }
};