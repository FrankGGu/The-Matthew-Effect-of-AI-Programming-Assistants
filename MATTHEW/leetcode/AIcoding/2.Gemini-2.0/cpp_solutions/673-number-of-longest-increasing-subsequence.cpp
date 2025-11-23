#include <vector>

using namespace std;

int findNumberOfLIS(vector<int>& nums) {
    int n = nums.size();
    if (n == 0) return 0;

    vector<int> lengths(n, 1);
    vector<int> counts(n, 1);
    int max_len = 1;

    for (int i = 1; i < n; ++i) {
        for (int j = 0; j < i; ++j) {
            if (nums[i] > nums[j]) {
                if (lengths[j] + 1 > lengths[i]) {
                    lengths[i] = lengths[j] + 1;
                    counts[i] = counts[j];
                } else if (lengths[j] + 1 == lengths[i]) {
                    counts[i] += counts[j];
                }
            }
        }
        max_len = max(max_len, lengths[i]);
    }

    int result = 0;
    for (int i = 0; i < n; ++i) {
        if (lengths[i] == max_len) {
            result += counts[i];
        }
    }

    return result;
}