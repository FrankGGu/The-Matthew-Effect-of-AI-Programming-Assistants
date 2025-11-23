#include <iostream>
#include <vector>
#include <string>
#include <queue>

using namespace std;

class Solution {
public:
    bool isTransformable(string s, string t) {
        vector<queue<int>> pos(10);
        for (int i = 0; i < s.size(); ++i) {
            pos[s[i] - '0'].push(i);
        }
        for (int i = 0; i < t.size(); ++i) {
            int d = t[i] - '0';
            if (pos[d].empty()) return false;
            for (int j = 0; j < d; ++j) {
                if (!pos[j].empty() && pos[j].front() < pos[d].front()) return false;
            }
            pos[d].pop();
        }
        return true;
    }
};