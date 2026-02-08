#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minLevelsToGainMorePoints(vector<int>& points) {
        int total = 0;
        for (int p : points) {
            total += p;
        }

        int sum = 0;
        int levels = 0;

        for (int i = 0; i < points.size(); ++i) {
            sum += points[i];
            if (sum > total - sum) {
                return i + 1;
            }
        }

        return -1;
    }
};