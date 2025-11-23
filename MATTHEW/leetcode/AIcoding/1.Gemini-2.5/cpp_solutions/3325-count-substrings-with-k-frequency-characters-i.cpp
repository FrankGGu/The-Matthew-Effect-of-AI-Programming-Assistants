#include <string>
#include <vector>

class Solution {
public:
    int countSubstringsWithKFrequency(std::string s, int k) {
        int n = s.length();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            std::vector<int> freq(26, 0);
            int unique_chars_count = 0;
            int valid_chars_count = 0;

            for (int j = i; j < n; ++j) {
                int char_idx = s[j] - 'a';

                if (freq[char_idx] == 0) {
                    unique_chars_count++;
                }

                freq[char_idx]++;

                if (freq[char_idx] == k) {
                    valid_chars_count++;
                } else if (freq[char_idx] == k + 1) {
                    valid_chars_count--;
                }

                if (unique_chars_count == valid_chars_count) {
                    count++;
                }
            }
        }

        return count;
    }
};