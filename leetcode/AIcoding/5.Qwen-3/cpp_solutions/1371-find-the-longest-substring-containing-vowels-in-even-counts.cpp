#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>

using namespace std;

class Solution {
public:
    int findTheLongestSubstring(string s) {
        unordered_map<char, int> map;
        map['a'] = 0;
        map['e'] = 1;
        map['i'] = 2;
        map['o'] = 3;
        map['u'] = 4;

        vector<int> state(32, -1);
        int result = 0;
        int mask = 0;

        state[0] = 0;

        for (int i = 0; i < s.size(); ++i) {
            char c = s[i];
            if (map.find(c) != map.end()) {
                int index = map[c];
                mask ^= (1 << index);
            }

            if (state[mask] == -1) {
                state[mask] = i + 1;
            } else {
                result = max(result, i - state[mask] + 1);
            }
        }

        return result;
    }
};