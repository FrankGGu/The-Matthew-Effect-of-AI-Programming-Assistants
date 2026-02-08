#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int beautifulBouquet(vector<int>& flowers, int cnt) {
        int MOD = 1e9 + 7;
        int n = flowers.size();
        int left = 0;
        int res = 0;
        unordered_map<int, int> freq;

        for (int right = 0; right < n; ++right) {
            freq[flowers[right]]++;
            while (freq[flowers[right]] > cnt) {
                freq[flowers[left]]--;
                left++;
            }
            res = (res + right - left + 1) % MOD;
        }
        return res;
    }
};