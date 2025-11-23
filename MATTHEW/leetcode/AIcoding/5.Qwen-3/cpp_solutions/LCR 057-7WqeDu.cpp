#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <set>

using namespace std;

class Solution {
public:
    bool containsNearbyAlmostDuplicate(int nums[], int numsSize, int k, int t) {
        if (numsSize == 0 || k <= 0 || t < 0) return false;
        set<long long> window;
        for (int i = 0; i < numsSize; ++i) {
            long long num = nums[i];
            long long bucket = num / static_cast<long long>(t + 1);
            if (window.find(bucket) != window.end()) return true;
            if (window.find(bucket - 1) != window.end() && abs(num - *window.find(bucket - 1)) <= t) return true;
            if (window.find(bucket + 1) != window.end() && abs(num - *window.find(bucket + 1)) <= t) return true;
            window.insert(bucket);
            if (i >= k) {
                long long removeBucket = nums[i - k] / static_cast<long long>(t + 1);
                window.erase(removeBucket);
            }
        }
        return false;
    }
};