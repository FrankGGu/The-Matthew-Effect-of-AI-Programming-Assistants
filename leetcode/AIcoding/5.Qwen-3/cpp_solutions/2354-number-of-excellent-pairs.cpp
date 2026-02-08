#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int canBeExellent(int x) {
        int count = 0;
        while (x > 0) {
            count += x & 1;
            x >>= 1;
        }
        return count;
    }

    int arrange(int x, int y) {
        int cntX = canBeExellent(x);
        int cntY = canBeExellent(y);
        if (cntX + cntY >= 2) {
            return 1;
        }
        return 0;
    }

    int excellentPairs(vector<int>& nums, int k) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int ans = 0;
        for (auto& [a, countA] : freq) {
            for (auto& [b, countB] : freq) {
                if (canBeExellent(a) + canBeExellent(b) >= k) {
                    ans += countA * countB;
                }
            }
        }

        return ans;
    }
};