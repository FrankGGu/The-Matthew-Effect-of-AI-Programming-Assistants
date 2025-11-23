#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long countPairs(int n, vector<int>& nums, int k) {
        unordered_map<int, int> freq;
        long long count = 0;
        for (int i = 0; i < n; ++i) {
            int rem = nums[i] % k;
            int complement = (k - rem) % k;
            count += freq[complement];
            freq[rem]++;
        }
        return count;
    }
};