#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int magicTower(vector<int>& nums) {
        long long total = 0;
        for (int num : nums) {
            total += num;
        }
        if (total <= 0) return 0;

        vector<pair<int, int>> monsters;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] < 0) {
                monsters.push_back({-nums[i], i});
            }
        }

        sort(monsters.begin(), monsters.end());

        int res = 0;
        long long health = 1;
        int idx = 0;

        while (health <= total) {
            if (idx >= monsters.size()) break;
            int damage = monsters[idx].first;
            int pos = monsters[idx].second;
            if (health > damage) {
                health -= damage;
                res++;
                idx++;
            } else {
                break;
            }
        }

        return res;
    }
};