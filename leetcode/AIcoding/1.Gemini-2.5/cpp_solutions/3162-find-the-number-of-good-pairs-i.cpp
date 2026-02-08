class Solution {
public:
    int numberOfGoodPairs(std::vector<int>& nums1, std::vector<int>& nums2, int k) {
        int count = 0;
        for (int i = 0; i < nums1.size(); ++i) {
            for (int j = 0; j < nums2.size(); ++j) {
                if ((long long)nums2[j] * k == nums1[i]) {
                    count++;
                }
            }
        }
        return count;
    }
};