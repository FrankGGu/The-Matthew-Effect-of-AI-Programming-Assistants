#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<int> maxNumber(std::vector<int>& nums1, std::vector<int>& nums2, int k) {
        int n1 = nums1.size();
        int n2 = nums2.size();
        std::vector<int> ans(k, 0);

        for (int i = std::max(0, k - n2); i <= std::min(k, n1); ++i) {
            std::vector<int> sub1 = maxArray(nums1, i);
            std::vector<int> sub2 = maxArray(nums2, k - i);
            std::vector<int> merged = merge(sub1, sub2);
            if (compareVectors(merged, 0, ans, 0)) {
                ans = merged;
            }
        }
        return ans;
    }

private:
    std::vector<int> maxArray(const std::vector<int>& nums, int k) {
        if (k == 0) {
            return {};
        }
        std::vector<int> res;
        int drop = nums.size() - k;
        for (int num : nums) {
            while (!res.empty() && res.back() < num && drop > 0) {
                res.pop_back();
                drop--;
            }
            res.push_back(num);
        }
        while (res.size() > k) {
            res.pop_back();
        }
        return res;
    }

    std::vector<int> merge(const std::vector<int>& nums1, const std::vector<int>& nums2) {
        std::vector<int> res(nums1.size() + nums2.size());
        int i = 0, j = 0, p = 0;
        while (p < res.size()) {
            if (compareVectors(nums1, i, nums2, j)) {
                res[p++] = nums1[i++];
            } else {
                res[p++] = nums2[j++];
            }
        }
        return res;
    }

    // Returns true if nums1[i...] is lexicographically greater than or equal to nums2[j...]
    bool compareVectors(const std::vector<int>& nums1, int i, const std::vector<int>& nums2, int j) {
        while (i < nums1.size() && j < nums2.size() && nums1[i] == nums2[j]) {
            i++;
            j++;
        }
        return j == nums2.size() || (i < nums1.size() && nums1[i] > nums2[j]);
    }
};