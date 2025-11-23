#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<vector<int>> findDifference(vector<int>& nums1, vector<int>& nums2) {
        unordered_set<int> set1(nums1.begin(), nums1.end());
        unordered_set<int> set2(nums2.begin(), nums2.end());

        vector<int> diff1;
        for (int num : nums1) {
            if (set2.find(num) == set2.end()) {
                if (find(diff1.begin(), diff1.end(), num) == diff1.end()) {
                    diff1.push_back(num);
                }
            }
        }

        vector<int> diff2;
        for (int num : nums2) {
            if (set1.find(num) == set1.end()) {
                if (find(diff2.begin(), diff2.end(), num) == diff2.end()) {
                    diff2.push_back(num);
                }
            }
        }

        return {diff1, diff2};
    }
};