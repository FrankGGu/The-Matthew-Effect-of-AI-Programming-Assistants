#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int rev(int n) {
        int res = 0;
        while (n > 0) {
            res = res * 10 + n % 10;
            n /= 10;
        }
        return res;
    }

    int countNicePairs(vector<int>& nums) {
        int count = 0;
        unordered_map<int, int> freq;
        int mod = 1e9 + 7;

        for (int num : nums) {
            int diff = num - rev(num);
            if (freq.count(diff)) {
                count = (count + freq[diff]) % mod;
                freq[diff]++;
            } else {
                freq[diff] = 1;
            }
        }

        return count;
    }
};