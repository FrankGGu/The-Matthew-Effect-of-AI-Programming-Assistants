#include <vector>

using namespace std;

class Solution {
public:
    long long numberOfPairs(vector<int>& nums1, vector<int>& nums2, int diff) {
        vector<int> diffs;
        for (int i = 0; i < nums1.size(); ++i) {
            diffs.push_back(nums1[i] - nums2[i]);
        }

        long long count = 0;
        vector<int> sortedDiffs;
        for (int i = 0; i < diffs.size(); ++i) {
            int l = 0, r = sortedDiffs.size();
            while (l < r) {
                int mid = l + (r - l) / 2;
                if (sortedDiffs[mid] <= diffs[i] + diff) {
                    l = mid + 1;
                } else {
                    r = mid;
                }
            }
            count += sortedDiffs.size() - l;

            l = 0, r = sortedDiffs.size();
            while (l < r) {
                int mid = l + (r - l) / 2;
                if (sortedDiffs[mid] < diffs[i]) {
                    l = mid + 1;
                } else {
                    r = mid;
                }
            }
            sortedDiffs.insert(sortedDiffs.begin() + l, diffs[i]);
        }

        return count;
    }
};