#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfPairs(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        vector<int> diff(n);
        for (int i = 0; i < n; ++i) {
            diff[i] = nums1[i] - nums2[i];
        }
        sort(diff.begin(), diff.end());
        int count = 0;
        int left = 0;
        int right = n - 1;
        while (left < right) {
            if (diff[left] + diff[right] > 0) {
                count++;
                left++;
                right--;
            } else if (diff[left] + diff[right] < 0) {
                left++;
            } else {
                count++;
                left++;
                right--;
            }
        }
        return count;
    }
};