#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <random>
#include <chrono>

class Solution {
private:
    std::unordered_map<int, int> mapping;
    int sz;
    std::mt19937 gen;
    std::uniform_int_distribution<int> dis;

public:
    Solution(int n, std::vector<int>& blacklist) {
        sz = n - blacklist.size();

        std::unordered_set<int> blacklist_set;
        for (int b_val : blacklist) {
            blacklist_set.insert(b_val);
        }

        int last_valid_num = n - 1;
        for (int b_val : blacklist) {
            if (b_val < sz) {
                while (blacklist_set.count(last_valid_num)) {
                    last_valid_num--;
                }
                mapping[b_val] = last_valid_num;
                last_valid_num--;
            }
        }

        gen = std::mt19937(std::chrono::high_resolution_clock::now().time_since_epoch().count());
        dis = std::uniform_int_distribution<int>(0, sz - 1);
    }

    int pick() {
        int r = dis(gen);
        if (mapping.count(r)) {
            return mapping[r];
        }
        return r;
    }
};