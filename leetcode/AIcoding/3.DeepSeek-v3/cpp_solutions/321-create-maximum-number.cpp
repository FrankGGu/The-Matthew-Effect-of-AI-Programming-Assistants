class Solution {
public:
    vector<int> maxNumber(vector<int>& nums1, vector<int>& nums2, int k) {
        int n1 = nums1.size(), n2 = nums2.size();
        vector<int> res;
        for (int i = max(0, k - n2); i <= min(k, n1); ++i) {
            res = max(res, merge(maxArray(nums1, i), maxArray(nums2, k - i)));
        }
        return res;
    }

    vector<int> maxArray(vector<int>& nums, int k) {
        vector<int> res;
        int drop = nums.size() - k;
        for (int num : nums) {
            while (!res.empty() && res.back() < num && drop > 0) {
                res.pop_back();
                --drop;
            }
            res.push_back(num);
        }
        res.resize(k);
        return res;
    }

    vector<int> merge(vector<int> nums1, vector<int> nums2) {
        vector<int> res;
        while (!nums1.empty() || !nums2.empty()) {
            vector<int>& temp = nums1 > nums2 ? nums1 : nums2;
            res.push_back(temp[0]);
            temp.erase(temp.begin());
        }
        return res;
    }
};