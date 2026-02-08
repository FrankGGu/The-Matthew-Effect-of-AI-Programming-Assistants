#include <string>
#include <vector>

class Solution {
public:
    bool isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    bool vowelsGame(std::string s) {
        long long alice_points = 0;
        long long bob_points = 0;

        // current_vowel_count_prefix stores the number of vowels in s[0...j].
        // Let V[k] be the number of vowels in s[0...k-1]. V[0] = 0.
        // The number of vowels in substring s[i...j] is V[j+1] - V[i].
        // Let P[k] = V[k] % 2 be the parity of vowel count up to index k-1.
        // A substring s[i...j] has an odd number of vowels if P[j+1] != P[i].
        // A substring s[i...j] has an even number of vowels if P[j+1] == P[i].

        // count_even_prefix_parity: counts k (from 0 to j) such that P[k] is 0.
        // count_odd_prefix_parity: counts k (from 0 to j) such that P[k] is 1.

        long long current_vowel_count_prefix = 0;
        long long count_even_prefix_parity = 1; // P[0] (vowels in empty prefix) is 0, so initialize with 1 for P[0]
        long long count_odd_prefix_parity = 0;

        for (int j = 0; j < s.length(); ++j) {
            if (isVowel(s[j])) {
                current_vowel_count_prefix++;
            }

            int current_P_val = current_vowel_count_prefix % 2; // This is P[j+1]

            if (current_P_val == 1) { // P[j+1] is odd
                // Substrings s[i...j] with odd vowel count: need P[i] == 0 (different parity)
                alice_points += count_even_prefix_parity;
                // Substrings s[i...j] with even vowel count: need P[i] == 1 (same parity)
                bob_points += count_odd_prefix_parity;
                count_odd_prefix_parity++;
            } else { // P[j+1] is even
                // Substrings s[i...j] with odd vowel count: need P[i] == 1 (different parity)
                alice_points += count_odd_prefix_parity;
                // Substrings s[i...j] with even vowel count: need P[i] == 0 (same parity)
                bob_points += count_even_prefix_parity;
                count_even_prefix_parity++;
            }
        }

        return alice_points > bob_points;
    }
};