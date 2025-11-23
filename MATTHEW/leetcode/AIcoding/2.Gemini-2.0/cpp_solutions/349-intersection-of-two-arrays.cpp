#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> intersection(vector<int>& nums1, vector<int>& nums2) {
        unordered_set<int> set1(nums1.begin(), nums1.end());
        unordered_set<int> intersectionSet;
        vector<int> result;

        for (int num : nums2) {
            if (set1.count(num)) {
                intersectionSet.insert(num);
            }
        }

        for (int num : intersectionSet) {
            result.push_back(num);
        }

        return result;
    }
};