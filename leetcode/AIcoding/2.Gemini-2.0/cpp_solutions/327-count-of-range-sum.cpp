#include <vector>

using namespace std;

class Solution {
public:
    int countRangeSum(vector<int>& nums, int lower, int upper) {
        int n = nums.size();
        vector<long long> sums(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            sums[i + 1] = sums[i] + nums[i];
        }
        return countAndMerge(sums, 0, n + 1, lower, upper);
    }

private:
    int countAndMerge(vector<long long>& sums, int start, int end, int lower, int upper) {
        if (end - start <= 1) {
            return 0;
        }
        int mid = (start + end) / 2;
        int count = countAndMerge(sums, start, mid, lower, upper) + countAndMerge(sums, mid, end, lower, upper);
        int i = start, j = mid, k = mid, l = mid;
        vector<long long> cache(end - start);
        int r = 0;
        for (; i < mid; ++i) {
            while (k < end && sums[k] - sums[i] < lower) {
                k++;
            }
            while (l < end && sums[l] - sums[i] <= upper) {
                l++;
            }
            count += l - k;
            while (j < end && sums[j] < sums[i]) {
                cache[r++] = sums[j++];
            }
            cache[r++] = sums[i];
        }
        copy(cache.begin(), cache.begin() + r, sums.begin() + start);
        return count;
    }
};