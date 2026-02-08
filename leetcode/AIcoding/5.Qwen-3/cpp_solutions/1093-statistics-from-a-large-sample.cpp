#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<double> sampleStats(vector<int>& count, vector<double>& sum) {
        int n = count.size();
        double mean = 0.0;
        double median = 0.0;
        double mode = 0.0;
        double maxVal = 0.0;
        double minVal = 0.0;
        long long total = 0;
        long long mid = 0;
        long long mid2 = 0;
        map<double, int> freqMap;

        for (int i = 0; i < n; ++i) {
            if (count[i] > 0) {
                if (minVal == 0.0) {
                    minVal = sum[i];
                }
                maxVal = sum[i];
                freqMap[sum[i]] += count[i];
                total += count[i];
            }
        }

        for (auto& [val, freq] : freqMap) {
            if (freq > freqMap[mode]) {
                mode = val;
            }
        }

        long long cnt = 0;
        long long mid1 = total / 2;
        long long mid2_ = (total + 1) / 2;
        for (int i = 0; i < n; ++i) {
            if (count[i] > 0) {
                if (cnt + count[i] >= mid1 && mid == 0) {
                    mid = sum[i];
                }
                if (cnt + count[i] >= mid2_ && mid2 == 0) {
                    mid2 = sum[i];
                }
                cnt += count[i];
            }
        }

        median = (mid + mid2) / 2.0;

        for (int i = 0; i < n; ++i) {
            if (count[i] > 0) {
                mean += sum[i] * count[i];
            }
        }
        mean /= total;

        return {mean, median, mode, maxVal, minVal};
    }
};