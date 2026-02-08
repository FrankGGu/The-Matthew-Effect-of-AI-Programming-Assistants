#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string smallestSubsequence(std::string s, int k, char letter, int occurrence) {
        int n = s.length();
        std::vector<int> suffix_letter_count(n + 1, 0);
        for (int i = n - 1; i >= 0; --i) {
            suffix_letter_count[i] = suffix_letter_count[i+1];
            if (s[i] == letter) {
                suffix_letter_count[i]++;
            }
        }

        std::string ans = "";
        int current_letter_count_in_ans = 0;

        for (int i = 0; i < n; ++i) {
            char c = s[i];

            while (!ans.empty() && ans.back() > c && 
                   (ans.length() - 1 + (n - i) >= k) && 
                   (ans.back() != letter || (current_letter_count_in_ans - 1 + suffix_letter_count[i] >= occurrence))) {

                if (ans.back() == letter) {
                    current_letter_count_in_ans--;
                }
                ans.pop_back();
            }

            bool can_push_c = false;
            if (c == letter) {
                can_push_c = (ans.length() < k);
            } else { // c is not 'letter'
                can_push_c = (ans.length() < k && current_letter_count_in_ans + suffix_letter_count[i+1] >= occurrence);
            }

            if (can_push_c) {
                ans.push_back(c);
                if (c == letter) {
                    current_letter_count_in_ans++;
                }
            }
        }

        return ans;
    }
};