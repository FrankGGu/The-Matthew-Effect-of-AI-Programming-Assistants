#include <string>
#include <vector>
#include <set>
#include <utility>

class Solution {
public:
    int distinctEchoSubstrings(std::string text) {
        int n = text.length();
        if (n == 0) {
            return 0;
        }

        long long p1 = 31, m1 = 1e9 + 7;
        long long p2 = 37, m2 = 1e9 + 9;

        std::vector<long long> p_pow1(n + 1);
        std::vector<long long> p_pow2(n + 1);
        std::vector<long long> h1(n + 1, 0);
        std::vector<long long> h2(n + 1, 0);

        p_pow1[0] = 1;
        p_pow2[0] = 1;

        for (int i = 0; i < n; ++i) {
            p_pow1[i + 1] = (p_pow1[i] * p1) % m1;
            p_pow2[i + 1] = (p_pow2[i] * p2) % m2;
            h1[i + 1] = (h1[i] * p1 + (text[i] - 'a' + 1)) % m1;
            h2[i + 1] = (h2[i] * p2 + (text[i] - 'a' + 1)) % m2;
        }

        std::set<std::pair<long long, long long>> distinct_hashes;

        for (int i = 0; i < n; ++i) {
            for (int k = 1; i + 2 * k <= n; ++k) {
                long long hash1_part1 = (h1[i + k] - (h1[i] * p_pow1[k]) % m1 + m1) % m1;
                long long hash2_part1 = (h2[i + k] - (h2[i] * p_pow2[k]) % m2 + m2) % m2;

                long long hash1_part2 = (h1[i + 2 * k] - (h1[i + k] * p_pow1[k]) % m1 + m1) % m1;
                long long hash2_part2 = (h2[i + 2 * k] - (h2[i + k] * p_pow2[k]) % m2 + m2) % m2;

                if (hash1_part1 == hash1_part2 && hash2_part1 == hash2_part2) {
                    distinct_hashes.insert({hash1_part1, hash2_part1});
                }
            }
        }

        return distinct_hashes.size();
    }
};