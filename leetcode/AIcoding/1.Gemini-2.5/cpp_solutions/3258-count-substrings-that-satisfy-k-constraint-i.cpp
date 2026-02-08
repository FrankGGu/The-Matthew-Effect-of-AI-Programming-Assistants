#include <string>
#include <vector>
#include <map>

class Solution {
public:
    long long countSubstrings(std::string s, int k) {
        long long count = 0;
        int left = 0;
        std::map<char, int> freq;

        for (int right = 0; right < s.length(); ++right) {
            freq[s[right]]++;

            while (freq.size() > k) {
                freq[s[left]]--;
                if (freq[s[left]] == 0) {
                    freq.erase(s[left]);
                }
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    }
};