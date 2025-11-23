#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    long long countSubstrings(string s, int k) {
        int n = s.length();
        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            vector<int> freq(26, 0);
            int distinct = 0;
            for (int j = i; j < n; ++j) {
                if (freq[s[j] - 'a'] == 0) {
                    distinct++;
                }
                freq[s[j] - 'a']++;
                if (distinct == k) {
                    ans++;
                } else if (distinct > k) {
                    break;
                }
            }
        }
        return ans;
    }
};