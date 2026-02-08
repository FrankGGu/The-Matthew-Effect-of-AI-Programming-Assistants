#include <string>
#include <vector>
#include <unordered_map>
#include <utility> // For std::pair

struct pair_hash {
    template <class T1, class T2>
    std::size_t operator () (const std::pair<T1,T2> &p) const {
        auto h1 = std::hash<T1>{}(p.first);
        auto h2 = std::hash<T2>{}(p.second);
        // A common way to combine hashes
        return h1 ^ (h2 << 1); 
    }
};

class Solution {
public:
    // Constants for Rabin-Karp hashing
    long long P1 = 31; // A prime number for the first base
    long long M1 = 1e9 + 7; // A large prime modulus for the first hash
    long long P2 = 131; // Another prime number for the second base
    long long M2 = 1e9 + 9; // Another large prime modulus for the second hash

    std::vector<long long> p_pow1; // Precomputed powers of P1 modulo M1
    std::vector<long long> p_pow2; // Precomputed powers of P2 modulo M2
    int N_len; // Length of the input string s

    // Helper function to check if a duplicate substring of a given length exists.
    // If found, updates 'start_idx' with the starting index of one such duplicate.
    bool check(int len, const std::string& s, int& start_idx) {
        if (len == 0) {
            start_idx = 0; // A 0-length substring is at any index, e.g., 0
            return true; // A zero-length string is always a duplicate
        }
        if (len > N_len) { 
            return false; // Cannot have a duplicate longer than the string itself
        }

        // Map to store hash pairs and the list of starting indices where they occur
        std::unordered_map<std::pair<long long, long long>, std::vector<int>, pair_hash> hashes_to_indices;

        long long current_h1 = 0;
        long long current_h2 = 0;

        // Calculate hash for the first substring s[0...len-1]
        for (int i = 0; i < len; ++i) {
            current_h1 = (current_h1 * P1 + (s[i] - 'a' + 1)) % M1;
            current_h2 = (current_h2 * P2 + (s[i] - 'a' + 1)) % M2;
        }
        hashes_to_indices[{current_h1, current_h2}].push_back(0);

        // Calculate rolling hashes for subsequent substrings
        for (int i = 1; i <= N_len - len; ++i) {
            // Remove contribution of the character s[i-1] from the hash
            current_h1 = (current_h1 - (s[i-1] - 'a' + 1) * p_pow1[len-1] % M1 + M1) % M1;
            current_h2 = (current_h2 - (s[i-1] - 'a' + 1) * p_pow2[len-1] % M2 + M2) % M2;

            // Shift the hash and add contribution of the new character s[i+len-1]
            current_h1 = (current_h1 * P1 % M1 + (s[i+len-1] - 'a' + 1)) % M1;
            current_h2 = (current_h2 * P2 % M2 + (s[i+len-1] - 'a' + 1)) % M2;

            // Check if this hash pair has been seen before
            if (hashes_to_indices.count({current_h1, current_h2})) {
                // Potential hash collision or actual duplicate. Verify by character-by-character comparison.
                for (int prev_idx : hashes_to_indices[{current_h1, current_h2}]) {
                    bool match = true;
                    for (int k = 0; k < len; ++k) {
                        if (s[prev_idx + k] != s[i + k]) {
                            match = false;
                            break;
                        }
                    }
                    if (match) {
                        start_idx = i; // Found a duplicate starting at index 'i'
                        return true;
                    }
                }
            }
            // Add the current index to the list for this hash pair
            hashes_to_indices[{current_h1, current_h2}].push_back(i);
        }
        return false; // No duplicate substring of this length found
    }

    std::string longestDupSubstring(std::string s) {
        N_len = s.length();

        // Precompute powers of P1 and P2 up to N_len
        p_pow1.resize(N_len + 1);
        p_pow2.resize(N_len + 1);
        p_pow1[0] = 1;
        p_pow2[0] = 1;
        for (int i = 1; i <= N_len; ++i) {
            p_pow1[i] = (p_pow1[i-1] * P1) % M1;
            p_pow2[i] = (p_pow2[i-1] * P2) % M2;
        }

        int low = 0, high = N_len - 1; // Binary search range for the length of the duplicate substring
        int ans_len = 0; // Stores the length of the longest duplicate substring found
        int ans_start_idx = 0; // Stores the starting index of the longest duplicate substring found

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int current_start_idx = -1; // To store the starting index if a duplicate of length 'mid' is found

            if (check(mid, s, current_start_idx)) {
                ans_len = mid;
                ans_start_idx = current_start_idx;
                low = mid + 1; // Try to find an even longer duplicate
            } else {
                high = mid - 1; // Need to look for a shorter duplicate
            }
        }

        // Return the longest duplicate substring using the stored length and starting index
        return s.substr(ans_start_idx, ans_len);
    }
};