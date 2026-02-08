#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

using namespace std;

class Solution {
public:
    string minNumber(vector<int>& nums1, vector<int>& nums2) {
        vector<int> common;
        for (int num : nums1) {
            if (find(nums2.begin(), nums2.end(), num) != nums2.end()) {
                common.push_back(num);
            }
        }
        if (!common.empty()) {
            int minCommon = *min_element(common.begin(), common.end());
            return to_string(minCommon);
        }
        int min1 = *min_element(nums1.begin(), nums1.end());
        int min2 = *min_element(nums2.begin(), nums2.end());
        return min1 < min2 ? to_string(min1) + to_string(min2) : to_string(min2) + to_string(min1);
    }
};