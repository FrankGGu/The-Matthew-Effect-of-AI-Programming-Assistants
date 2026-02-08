#include <string>
#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    int beautySum(string s) {
        int n = s.length();
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                vector<int> freq(26, 0);
                for (int k = i; k <= j; ++k) {
                    freq[s[k] - 'a']++;
                }
                int max_freq = 0;
                int min_freq = 1000;
                for (int k = 0; k < 26; ++k) {
                    if (freq[k] > 0) {
                        max_freq = max(max_freq, freq[k]);
                        min_freq = min(min_freq, freq[k]);
                    }
                }
                ans += max_freq - min_freq;
            }
        }
        return ans;
    }
};