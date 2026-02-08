#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countNicePairs(vector<int>& nums) {
        unordered_map<int, int> freq;
        int mod = 1e9 + 7;
        int count = 0;
        for (int num : nums) {
            int rev = 0;
            int n = num;
            while (n > 0) {
                rev = rev * 10 + n % 10;
                n /= 10;
            }
            count = (count + freq[rev]) % mod;
            freq[num - rev]++;
        }
        return count;
    }
};