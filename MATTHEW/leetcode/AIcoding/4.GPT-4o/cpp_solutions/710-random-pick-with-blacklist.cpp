#include <vector>
#include <unordered_map>
#include <random>

class Solution {
public:
    Solution(int N, std::vector<int>& blacklist) {
        max = N - blacklist.size();
        for (int b : blacklist) {
            blacklistSet.insert(b);
        }
        for (int b : blacklist) {
            if (b >= max) {
                continue;
            }
            while (blacklistSet.count(N - 1)) {
                N--;
            }
            mapping[b] = N - 1;
            N--;
        }
    }

    int pick() {
        int idx = rand() % max;
        return mapping.count(idx) ? mapping[idx] : idx;
    }

private:
    int max;
    std::unordered_map<int, int> mapping;
    std::unordered_set<int> blacklistSet;
};