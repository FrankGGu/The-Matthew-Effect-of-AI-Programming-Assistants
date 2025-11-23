class Solution {
public:
    int maximumSetSize(vector<int>& nums1, vector<int>& nums2) {
        unordered_set<int> s1(nums1.begin(), nums1.end());
        unordered_set<int> s2(nums2.begin(), nums2.end());
        int common = 0;
        for (int num : s1) {
            if (s2.count(num)) {
                common++;
            }
        }
        int n = nums1.size();
        int unique1 = s1.size() - common;
        int unique2 = s2.size() - common;
        int maxPossible = min(n / 2, unique1) + min(n / 2, unique2) + common;
        return min(maxPossible, n);
    }
};