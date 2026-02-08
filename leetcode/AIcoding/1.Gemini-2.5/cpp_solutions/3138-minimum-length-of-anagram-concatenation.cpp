#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> get_freq(const std::string& s_block) {
        std::vector<int> freq(26, 0);
        for (char c : s_block) {
            freq[c - 'a']++;
        }
        return freq;
    }

    int minLengthAfterAnagramConcatenation(std::string s) {
        int n = s.length();

        for (int k = 1; k <= n; ++k) {
            if (n % k == 0) {
                std::vector<int> base_freq = get_freq(s.substr(0, k));

                bool all_anagrams = true;
                for (int i = 1; i < n / k; ++i) {
                    std::string current_block = s.substr(i * k, k);
                    std::vector<int> current_freq = get_freq(current_block);

                    if (current_freq != base_freq) {
                        all_anagrams = false;
                        break;
                    }
                }

                if (all_anagrams) {
                    return k;
                }
            }
        }
        return n;
    }
};