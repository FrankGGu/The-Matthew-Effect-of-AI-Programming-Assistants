#include <vector>
#include <numeric>
#include <random>

using namespace std;

class Solution {
private:
    vector<int> prefixSums;
    int totalSum;
    mt19937 gen;
    uniform_int_distribution<int> distrib;

public:
    Solution(vector<int>& w) : gen(random_device{}()) {
        prefixSums.resize(w.size());
        partial_sum(w.begin(), w.end(), prefixSums.begin());
        totalSum = prefixSums.back();
        distrib = uniform_int_distribution<int>(1, totalSum);
    }

    int pickIndex() {
        int target = distrib(gen);
        int low = 0, high = prefixSums.size() - 1;
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