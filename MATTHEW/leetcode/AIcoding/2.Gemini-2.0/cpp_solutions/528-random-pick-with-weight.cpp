#include <vector>
#include <random>

using namespace std;

class Solution {
private:
    vector<int> prefixSums;
    int totalSum;
    mt19937 gen;
    uniform_int_distribution<> distrib;

public:
    Solution(vector<int>& w) {
        prefixSums.resize(w.size());
        totalSum = 0;
        for (int i = 0; i < w.size(); ++i) {
            totalSum += w[i];
            prefixSums[i] = totalSum;
        }
        random_device rd;
        gen = mt19937(rd());
        distrib = uniform_int_distribution<>(1, totalSum);
    }

    int pickIndex() {
        int target = distrib(gen);
        int low = 0;
        int high = prefixSums.size() - 1;
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (prefixSums[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
};