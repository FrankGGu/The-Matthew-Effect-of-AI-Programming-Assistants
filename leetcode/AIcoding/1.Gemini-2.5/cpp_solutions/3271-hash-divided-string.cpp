#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    long long P1 = 31;
    long long M1 = 1e9 + 7;

    std::vector<long long> powers;
    std::vector<long long> prefix_hashes;

    void precompute_hashes(const std::string& s) {
        int n = s.length();
        powers.resize(n + 1);
        prefix_hashes.resize(n + 1, 0);

        powers[0] = 1;
        for (int i = 1; i <= n; ++i) {
            powers[i] = (powers[i - 1] * P1) % M1;
        }

        for (int i = 0; i < n; ++i) {
            prefix_hashes[i + 1] = (prefix_hashes[i] * P1 + (s[i] - 'a' + 1)) % M1;
        }
    }

    long long get_substring_hash(int start, int end) {
        long long sub_len = end - start + 1;
        long long hash_val = (prefix_hashes[end + 1] - (prefix_hashes[start] * powers[sub_len]) % M1 + M1) % M1;
        return hash_val;
    }

    bool canDivideIntoIdenticalSubstrings(std::string s, int k) {
        int n = s.length();

        if (n == 0) {
            return false;
        }
        if (k <= 0) {
            return false;
        }
        if (n % k != 0) {
            return false;
        }

        int sub_len = n / k;
        if (sub_len == 0) {
            return false;
        }

        precompute_hashes(s);

        long long first_sub_hash = get_substring_hash(0, sub_len - 1);

        for (int i = 1; i < k; ++i) {
            int current_start = i * sub_len;
            int current_end = current_start + sub_len - 1;
            if (get_substring_hash(current_start, current_end) != first_sub_hash) {
                return false;
            }
        }

        return true;
    }
};