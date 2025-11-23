#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countSpecialCharacters(string s, int k) {
        unordered_map<char, int> freq;
        int count = 0;
        int left = 0;
        int distinct = 0;

        for (int right = 0; right < s.length(); ++right) {
            if (freq[s[right]] == 0) {
                distinct++;
            }
            freq[s[right]]++;

            while (distinct > k) {
                freq[s[left]]--;
                if (freq[s[left]] == 0) {
                    distinct--;
                }
                left++;
            }

            count += right - left + 1;
        }

        return count;
    }
};