class Solution {
public:
    vector<int> reshapeData(vector<int>& nums1, vector<int>& nums2) {
        vector<int> result;
        result.reserve(nums1.size() + nums2.size());
        result.insert(result.end(), nums1.begin(), nums1.end());
        result.insert(result.end(), nums2.begin(), nums2.end());
        return result;
    }
};