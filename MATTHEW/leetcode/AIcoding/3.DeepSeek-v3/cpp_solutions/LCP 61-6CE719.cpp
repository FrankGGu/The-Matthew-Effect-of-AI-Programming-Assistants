#include <vector>
using namespace std;

class Solution {
public:
    int temperatureTrend(vector<int>& temperatureA, vector<int>& temperatureB) {
        int n = temperatureA.size();
        int count = 0;
        for (int i = 1; i < n; ++i) {
            int trendA = 0, trendB = 0;
            if (temperatureA[i] > temperatureA[i-1]) trendA = 1;
            else if (temperatureA[i] < temperatureA[i-1]) trendA = -1;
            if (temperatureB[i] > temperatureB[i-1]) trendB = 1;
            else if (temperatureB[i] < temperatureB[i-1]) trendB = -1;
            if (trendA == trendB) ++count;
        }
        return count;
    }
};