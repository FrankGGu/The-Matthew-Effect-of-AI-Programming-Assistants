#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums1, vector<int>& nums2) {
        int sum1 = accumulate(nums1.begin(), nums1.end(), 0);
        int sum2 = accumulate(nums2.begin(), nums2.end(), 0);

        if (sum1 == sum2) {
            return 0;
        }

        if ((nums1.size() > nums2.size() * 6) || (nums2.size() > nums1.size() * 6)) {
            return -1;
        }

        if (sum1 > sum2) {
            swap(nums1, nums2);
        }

        int diff = abs(sum1 - sum2);
        vector<int> changes;
        for (int num : nums1) {
            changes.push_back(6 - num);
        }
        for (int num : nums2) {
            changes.push_back(num - 1);
        }

        sort(changes.rbegin(), changes.rend());

        int operations = 0;
        int currentSum = 0;
        for (int change : changes) {
            currentSum += change;
            operations++;
            if (currentSum >= diff) {
                return operations;
            }
        }

        return -1;
    }
};