#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long putMarbles(vector<int>& weights, int k) {
        int n = weights.size();
        if (k == 1 || k == n) {
            return 0;
        }

        vector<long long> splits;
        for (int i = 0; i < n - 1; ++i) {
            splits.push_back(weights[i] + weights[i + 1]);
        }

        sort(splits.begin(), splits.end());

        long long max_sum = 0;
        long long min_sum = 0;
        for (int i = 0; i < k - 1; ++i) {
            min_sum += splits[i];
            max_sum += splits[n - 2 - i];
        }

        return max_sum - min_sum;
    }
};