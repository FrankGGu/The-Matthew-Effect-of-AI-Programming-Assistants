#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numTilePossibilities(string tiles) {
        unordered_map<char, int> count;
        for (char c : tiles) {
            count[c]++;
        }
        return dfs(count);
    }

    int dfs(unordered_map<char, int>& count) {
        int res = 0;
        for (auto& [c, cnt] : count) {
            if (cnt > 0) {
                res++;
                count[c]--;
                res += dfs(count);
                count[c]++;
            }
        }
        return res;
    }
};