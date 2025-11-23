#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestAwesome(string s) {
        unordered_map<int, int> map;
        map[0] = -1;
        int res = 0, mask = 0;
        for (int i = 0; i < s.length(); ++i) {
            int bit = s[i] - '0';
            mask ^= (1 << bit);
            if (map.find(mask) != map.end()) {
                res = max(res, i - map[mask]);
            } else {
                map[mask] = i;
            }
            for (int j = 0; j < 10; ++j) {
                int temp = mask ^ (1 << j);
                if (map.find(temp) != map.end()) {
                    res = max(res, i - map[temp]);
                }
            }
        }
        return res;
    }
};