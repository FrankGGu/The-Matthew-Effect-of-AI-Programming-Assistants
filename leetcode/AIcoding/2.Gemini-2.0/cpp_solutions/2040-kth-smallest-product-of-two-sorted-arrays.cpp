#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long kthSmallestProduct(vector<int>& nums1, vector<int>& nums2, long long k) {
        long long left = -1e10, right = 1e10;
        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long count = 0;
            for (int i = 0; i < nums1.size(); ++i) {
                if (nums1[i] >= 0) {
                    int l = 0, r = nums2.size();
                    while (l < r) {
                        int m = l + (r - l) / 2;
                        if ((long long)nums1[i] * nums2[m] <= mid) {
                            l = m + 1;
                        } else {
                            r = m;
                        }
                    }
                    count += l;
                } else {
                    int l = 0, r = nums2.size();
                    while (l < r) {
                        int m = l + (r - l) / 2;
                        if ((long long)nums1[i] * nums2[m] <= mid) {
                            r = m;
                        } else {
                            l = m + 1;
                        }
                    }
                    count += nums2.size() - l;
                }
            }
            if (count < k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};