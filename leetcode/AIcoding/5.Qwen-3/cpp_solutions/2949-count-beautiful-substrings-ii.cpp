#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countBeautifulSubstrings(string s, int k) {
        int n = s.size();
        int result = 0;
        vector<int> prefix(26, 0);
        for (int i = 0; i < n; ++i) {
            prefix[s[i] - 'a']++;
            if (i + 1 >= k) {
                bool valid = true;
                for (int j = 0; j < 26; ++j) {
                    if (prefix[j] % 2 != 0) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    result++;
                }
            }
        }
        return result;
    }
};