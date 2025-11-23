#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maxNumber(vector<int>& nums1, vector<int>& nums2, int k) {
        vector<int> result;
        int n = nums1.size(), m = nums2.size();
        for (int i = max(0, k - m); i <= min(k, n); ++i) {
            vector<int> candidate = merge(maxSubsequence(nums1, i), maxSubsequence(nums2, k - i));
            if (candidate > result) {
                result = candidate;
            }
        }
        return result;
    }

private:
    vector<int> maxSubsequence(vector<int>& nums, int k) {
        vector<int> result;
        int to_remove = nums.size() - k;
        for (int num : nums) {
            while (to_remove > 0 && !result.empty() && result.back() < num) {
                result.pop_back();
                to_remove--;
            }
            result.push_back(num);
        }
        result.resize(k);
        return result;
    }

    vector<int> merge(vector<int>& a, vector<int>& b) {
        vector<int> result;
        int i = 0, j = 0;
        while (i < a.size() && j < b.size()) {
            if (a[i] > b[j]) {
                result.push_back(a[i++]);
            } else {
                result.push_back(b[j++]);
            }
        }
        while (i < a.size()) result.push_back(a[i++]);
        while (j < b.size()) result.push_back(b[j++]);
        return result;
    }
};