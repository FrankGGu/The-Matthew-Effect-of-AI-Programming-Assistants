#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
private:
    unordered_map<int, int> memo;

    int getPower(int n) {
        if (n == 1) return 0;
        if (memo.find(n) != memo.end()) return memo[n];
        if (n % 2 == 0) {
            return memo[n] = 1 + getPower(n / 2);
        } else {
            return memo[n] = 1 + getPower(3 * n + 1);
        }
    }

public:
    vector<int> sortJumbled(vector<int>& mapping, vector<int>& nums) {
        vector<pair<int, int>> indexedNums;
        for (int i = 0; i < nums.size(); ++i) {
            indexedNums.emplace_back(i, nums[i]);
        }

        auto compare = [&](const pair<int, int>& a, const pair<int, int>& b) {
            int powerA = getPower(a.second);
            int powerB = getPower(b.second);
            if (powerA != powerB) return powerA < powerB;
            return a.first < b.first;
        };

        sort(indexedNums.begin(), indexedNums.end(), compare);

        vector<int> result;
        for (const auto& p : indexedNums) {
            result.push_back(nums[p.first]);
        }

        return result;
    }
};