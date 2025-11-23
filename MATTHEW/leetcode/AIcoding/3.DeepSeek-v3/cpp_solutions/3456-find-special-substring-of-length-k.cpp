#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string findSpecialSubstring(string s, int k) {
        unordered_map<char, int> freq;
        int n = s.size();
        int left = 0;
        int max_count = 0;
        string result = "";

        for (int right = 0; right < n; ++right) {
            freq[s[right]]++;
            max_count = max(max_count, freq[s[right]]);

            if (right - left + 1 == k) {
                if (max_count >= (k + 1) / 2) {
                    return s.substr(left, k);
                }
                freq[s[left]]--;
                if (freq[s[left]] == 0) {
                    freq.erase(s[left]);
                }
                left++;
            }
        }

        return "";
    }
};