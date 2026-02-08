#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> temperatureTrend(vector<int>& temperatureA, vector<int>& temperatureB) {
        int n = temperatureA.size();
        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (temperatureA[i] > temperatureB[i]) {
                result.push_back(1);
            } else if (temperatureA[i] < temperatureB[i]) {
                result.push_back(-1);
            } else {
                result.push_back(0);
            }
        }
        return result;
    }
};