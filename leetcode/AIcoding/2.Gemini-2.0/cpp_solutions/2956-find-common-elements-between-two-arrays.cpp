#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> findIntersectionValues(vector<int>& nums1, vector<int>& nums2) {
        int count1 = 0;
        int count2 = 0;

        unordered_set<int> set1(nums1.begin(), nums1.end());
        unordered_set<int> set2(nums2.begin(), nums2.end());

        for (int num : nums1) {
            if (set2.count(num)) {
                count1++;
            }
        }

        for (int num : nums2) {
            if (set1.count(num)) {
                count2++;
            }
        }

        return {count1, count2};
    }
};