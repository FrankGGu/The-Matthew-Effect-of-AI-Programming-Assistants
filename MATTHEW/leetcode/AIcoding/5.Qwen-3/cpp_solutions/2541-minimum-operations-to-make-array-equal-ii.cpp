#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    long long minOperationsToMakeArrayEqualII(vector<int>& nums1, vector<int>& nums2) {
        map<int, int> diff;
        for (int i = 0; i < nums1.size(); ++i) {
            int d = nums1[i] - nums2[i];
            diff[d]++;
        }

        long long operations = 0;
        for (auto it = diff.begin(); it != diff.end(); ++it) {
            if (it->second % 2 != 0) {
                return -1;
            }
            operations += (long long)abs(it->first) * (it->second / 2);
        }

        return operations;
    }
};