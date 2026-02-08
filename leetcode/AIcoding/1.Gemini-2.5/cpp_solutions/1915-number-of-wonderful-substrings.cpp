#include <string>
#include <vector>
#include <unordered_map>

class Solution {
public:
    long long wonderfulSubstrings(std::string word) {
        std::vector<long long> count(1024, 0);
        count[0] = 1;
        long long result = 0;
        int mask = 0;

        for (char c : word) {
            mask ^= 1 << (c - 'a');
            result += count[mask];
            for (int i = 0; i < 10; ++i) {
                result += count[mask ^ (1 << i)];
            }
            count[mask]++;
        }

        return result;
    }
};