#include <vector>
#include <algorithm>
#include <numeric>
#include <iomanip>

using namespace std;

class Solution {
public:
    vector<double> sampleStats(vector<int>& count) {
        long long total = 0;
        for (int c : count) {
            total += c;
        }

        double minimum = -1;
        double maximum = -1;
        double sum = 0;
        for (int i = 0; i < count.size(); ++i) {
            if (count[i] > 0) {
                if (minimum == -1) {
                    minimum = i;
                }
                maximum = i;
                sum += (double)i * count[i];
            }
        }

        double mean = sum / total;

        double median;
        long long currentCount = 0;
        int medianIndex1 = -1;
        int medianIndex2 = -1;

        if (total % 2 == 0) {
            long long target1 = total / 2;
            long long target2 = target1 + 1;
            for (int i = 0; i < count.size(); ++i) {
                currentCount += count[i];
                if (medianIndex1 == -1 && currentCount >= target1) {
                    medianIndex1 = i;
                }
                if (medianIndex2 == -1 && currentCount >= target2) {
                    medianIndex2 = i;
                    break;
                }
            }
            median = (medianIndex1 + medianIndex2) / 2.0;
        } else {
            long long target = (total + 1) / 2;
            for (int i = 0; i < count.size(); ++i) {
                currentCount += count[i];
                if (currentCount >= target) {
                    median = i;
                    break;
                }
            }
        }

        int mode = 0;
        int maxCount = 0;
        for (int i = 0; i < count.size(); ++i) {
            if (count[i] > maxCount) {
                maxCount = count[i];
                mode = i;
            }
        }

        return {minimum, maximum, mean, median, (double)mode};
    }
};