#include <vector>
#include <algorithm>

using namespace std;

long long putMarbles(vector<int>& weights, int k) {
    int n = weights.size();
    if (k == 1 || k == n) {
        return 0;
    }

    vector<int> pair_sums;
    for (int i = 0; i < n - 1; ++i) {
        pair_sums.push_back(weights[i] + weights[i + 1]);
    }

    sort(pair_sums.begin(), pair_sums.end());

    long long min_sum = 0;
    for (int i = 0; i < k - 1; ++i) {
        min_sum += pair_sums[i];
    }

    long long max_sum = 0;
    for (int i = n - 2; i >= n - k; --i) {
        max_sum += pair_sums[i];
    }

    return max_sum - min_sum;
}