#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>

class Solution {
public:
    std::vector<std::string> findRepeatedDnaSequences(std::string s) {
        std::vector<std::string> result;
        if (s.length() < 10) {
            return result;
        }

        std::unordered_map<char, int> char_to_int = {
            {'A', 0}, {'C', 1}, {'G', 2}, {'T', 3}
        };

        std::unordered_set<int> seen;
        std::unordered_set<int> repeated_hashes;

        int current_hash = 0;
        int L = 10;
        int mask = (1 << (L * 2)) - 1; // Mask for the last 20 bits

        for (int i = 0; i < s.length(); ++i) {
            current_hash = (current_hash << 2) | char_to_int[s[i]];

            if (i >= L - 1) {
                current_hash &= mask;

                if (seen.count(current_hash)) {
                    repeated_hashes.insert(current_hash);
                } else {
                    seen.insert(current_hash);
                }
            }
        }

        for (int hash_val : repeated_hashes) {
            std::string dna_seq = "";
            for (int i = 0; i < L; ++i) {
                int char_code = (hash_val >> (2 * (L - 1 - i))) & 3;
                if (char_code == 0) dna_seq += 'A';
                else if (char_code == 1) dna_seq += 'C';
                else if (char_code == 2) dna_seq += 'G';
                else dna_seq += 'T';
            }
            result.push_back(dna_seq);
        }

        return result;
    }
};