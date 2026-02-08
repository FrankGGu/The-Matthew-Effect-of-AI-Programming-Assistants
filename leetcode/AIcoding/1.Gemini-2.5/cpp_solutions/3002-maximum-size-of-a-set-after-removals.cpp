#include <vector>
#include <unordered_set>
#include <algorithm> // For std::min

class Solution {
public:
    int maximumSetSize(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();
        int n_half = n / 2;

        std::unordered_set<int> s1_set(nums1.begin(), nums1.end());
        std::unordered_set<int> s2_set(nums2.begin(), nums2.end());

        int common_count = 0;
        for (int x : s1_set) {
            if (s2_set.count(x)) {
                common_count++;
            }
        }

        int s1_only_count = s1_set.size() - common_count;
        int s2_only_count = s2_set.size() - common_count;

        int ans = 0;

        // Prioritize picking distinct elements unique to nums1
        // We can pick at most n_half elements from nums1, and at most s1_only_count distinct elements.
        int taken_s1_only = std::min(s1_only_count, n_half);
        ans += taken_s1_only;
        // Calculate remaining slots in nums1 that must be filled (potentially with common elements or duplicates)
        int remaining_slots_s1 = n_half - taken_s1_only;

        // Prioritize picking distinct elements unique to nums2
        // We can pick at most n_half elements from nums2, and at most s2_only_count distinct elements.
        int taken_s2_only = std::min(s2_only_count, n_half);
        ans += taken_s2_only;
        // Calculate remaining slots in nums2
        int remaining_slots_s2 = n_half - taken_s2_only;

        // Use remaining slots from both arrays to pick common elements
        int total_remaining_slots_for_common = remaining_slots_s1 + remaining_slots_s2;
        ans += std::min(common_count, total_remaining_slots_for_common);

        return ans;
    }
};