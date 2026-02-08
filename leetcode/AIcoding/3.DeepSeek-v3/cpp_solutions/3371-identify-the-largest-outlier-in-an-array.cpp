#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int identifyOutlier(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return -1;

        double mean = 0.0;
        for (int num : nums) {
            mean += num;
        }
        mean /= n;

        double maxDeviation = 0.0;
        int outlier = -1;

        for (int num : nums) {
            double deviation = abs(num - mean);
            if (deviation > maxDeviation) {
                maxDeviation = deviation;
                outlier = num;
            }
        }

        return outlier;
    }
};