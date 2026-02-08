#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long minimumTotalCost(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();

        long long cost = 0;
        int conflicts_count = 0;
        std::vector<int> counts(n + 1, 0);
        std::vector<int> f1(n + 1, 0);
        std::vector<int> f2(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            f1[nums1[i]]++;
            f2[nums2[i]]++;
            if (nums1[i] == nums2[i]) {
                cost += i;
                conflicts_count++;
                counts[nums1[i]]++;
            }
        }

        for (int i = 1; i <= n; ++i) {
            if (f1[i] + f2[i] > n) {
                return -1;
            }
        }

        if (conflicts_count == 0) {
            return 0;
        }

        int major_val = -1;
        int major_freq = 0;
        for (int i = 1; i <= n; ++i) {
            if (counts[i] > major_freq) {
                major_freq = counts[i];
                major_val = i;
            }
        }

        if (2 * major_freq <= conflicts_count) {
            return cost;
        }

        int needed = 2 * major_freq - conflicts_count;

        for (int i = 0; i < n; ++i) {
            if (needed == 0) {
                break;
            }
            if (nums1[i] != nums2[i] && nums1[i] != major_val && nums2[i] != major_val) {
                cost += i;
                needed--;
            }
        }

        return cost;
    }
};