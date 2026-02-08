#include <vector>
#include <unordered_map>

class Solution {
public:
    int fourSumCount(std::vector<int>& nums1, std::vector<int>& nums2, std_vector<int>& nums3, std::vector<int>& nums4) {
        std::unordered_map<int, int> sum12_counts;

        for (int n1 : nums1) {
            for (int n2 : nums2) {
                sum12_counts[n1 + n2]++;
            }
        }

        int count = 0;
        for (int n3 : nums3) {
            for (int n4 : nums4) {
                int target_complement = -(n3 + n4);
                if (sum12_counts.count(target_complement)) {
                    count += sum12_counts[target_complement];
                }
            }
        }

        return count;
    }
};