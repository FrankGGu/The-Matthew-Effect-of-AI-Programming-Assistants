#include <vector>

class Solution {
public:
    long long numberOfGoodPairs(std::vector<int>& nums1, std::vector<int>& nums2, int k) {
        std::vector<int> freq_nums2(1000001, 0); 

        for (int num_val : nums2) {
            freq_nums2[num_val]++;
        }

        long long good_pairs_count = 0;

        for (int num1_val : nums1) {
            if (num1_val % k == 0) {
                int required_nums2_val = num1_val / k;
                good_pairs_count += freq_nums2[required_nums2_val];
            }
        }

        return good_pairs_count;
    }
};