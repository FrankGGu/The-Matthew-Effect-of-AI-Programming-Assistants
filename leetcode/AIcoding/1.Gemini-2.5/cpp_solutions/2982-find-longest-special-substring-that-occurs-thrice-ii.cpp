#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int longestSpecialSubstring(std::string s) {
        std::vector<std::vector<int>> char_lengths(26);

        int n = s.length();
        int i = 0;
        while (i < n) {
            char current_char = s[i];
            int count = 0;
            while (i < n && s[i] == current_char) {
                count++;
                i++;
            }
            char_lengths[current_char - 'a'].push_back(count);
        }

        int max_overall_L = 0;

        for (int j = 0; j < 26; ++j) {
            std::vector<int>& v = char_lengths[j];
            if (v.empty()) {
                continue;
            }

            std::sort(v.rbegin(), v.rend()); // Sort lengths in descending order

            int current_char_max_L = 0;

            // Candidate 1: Three occurrences from a single longest block (v[0])
            // A block of length K can provide K - L + 1 occurrences of length L.
            // For 3 occurrences: K - L + 1 >= 3  => L <= K - 2.
            // The maximum L is K - 2.
            current_char_max_L = std::max(current_char_max_L, v[0] - 2);

            // Candidate 2: Three occurrences from two longest blocks (v[0] and v[1])
            // Let the lengths be K1 = v[0] and K2 = v[1].
            // We need 3 occurrences of length L.
            // We can get one occurrence from the second block (if K2 >= L).
            // We need two more occurrences from the first block (K1 - L + 1 >= 2 => L <= K1 - 1).
            // So, L must satisfy L <= K2 and L <= K1 - 1.
            // The maximum L is min(K2, K1 - 1).
            if (v.size() >= 2) {
                current_char_max_L = std::max(current_char_max_L, std::min(v[1], v[0] - 1));
            }

            // Candidate 3: Three occurrences from three longest blocks (v[0], v[1], v[2])
            // Let the lengths be K1 = v[0], K2 = v[1], K3 = v[2].
            // We can get one occurrence of length L from K1, one from K2, and one from K3.
            // This requires K1 >= L, K2 >= L, and K3 >= L.
            // Since v is sorted in descending order, min(K1, K2, K3) is K3.
            // The maximum L is K3.
            if (v.size() >= 3) {
                current_char_max_L = std::max(current_char_max_L, v[2]);
            }

            max_overall_L = std::max(max_overall_L, current_char_max_L);
        }

        return max_overall_L > 0 ? max_overall_L : -1;
    }
};