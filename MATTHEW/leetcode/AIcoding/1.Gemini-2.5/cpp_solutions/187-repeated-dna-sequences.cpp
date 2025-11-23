#include <vector>
#include <string>
#include <unordered_set>

class Solution {
public:
    int char_to_int(char c) {
        switch (c) {
            case 'A': return 0;
            case 'C': return 1;
            case 'G': return 2;
            case 'T': return 3;
        }
        return -1; 
    }

    std::vector<std::string> findRepeatedDnaSequences(std::string s) {
        std::vector<std::string> result;
        if (s.length() < 10) {
            return result;
        }

        std::unordered_set<int> seen_hashes;
        std::unordered_set<int> repeated_hashes;

        int current_hash = 0;
        for (int i = 0; i < 9; ++i) {
            current_hash = (current_hash << 2) | char_to_int(s[i]);
        }

        int mask = (1 << 20) - 1; // Mask to keep only the last 20 bits

        for (int i = 0; i <= (int)s.length() - 10; ++i) {
            current_hash = ((current_hash << 2) & mask) | char_to_int(s[i+9]);

            if (seen_hashes.count(current_hash)) {
                repeated_hashes.insert(current_hash);
            } else {
                seen_hashes.insert(current_hash);
            }
        }

        char int_to_char[] = {'A', 'C', 'G', 'T'};

        for (int hash_val : repeated_hashes) {
            std::string temp_s(10, ' ');
            int temp_hash = hash_val;
            for (int k = 9; k >= 0; --k) {
                temp_s[k] = int_to_char[temp_hash & 3];
                temp_hash >>= 2;
            }
            result.push_back(temp_s);
        }

        return result;
    }
};