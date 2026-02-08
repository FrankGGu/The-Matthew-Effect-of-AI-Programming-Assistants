#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> twoOutOfThree(vector<int>& nums1, vector<int>& nums2, vector<int>& nums3) {
        unordered_set<int> set1(nums1.begin(), nums1.end());
        unordered_set<int> set2(nums2.begin(), nums2.end());
        unordered_set<int> set3(nums3.begin(), nums3.end());

        unordered_set<int> result_set;
        vector<int> result;

        for (int num : set1) {
            if (set2.count(num) || set3.count(num)) {
                result_set.insert(num);
            }
        }

        for (int num : set2) {
            if (set1.count(num) || set3.count(num)) {
                result_set.insert(num);
            }
        }

        for (int num : set3) {
            if (set1.count(num) || set2.count(num)) {
                result_set.insert(num);
            }
        }

        for (int num : result_set) {
            result.push_back(num);
        }

        return result;
    }
};