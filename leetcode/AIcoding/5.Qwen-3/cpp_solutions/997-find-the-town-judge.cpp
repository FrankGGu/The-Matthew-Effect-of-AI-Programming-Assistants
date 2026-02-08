#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findJudge(int n, vector<vector<int>>& trust) {
        unordered_map<int, int> judgeCount;
        for (int i = 1; i <= n; ++i) {
            judgeCount[i] = 0;
        }

        for (const auto& t : trust) {
            int person = t[0];
            int judge = t[1];
            judgeCount[person]--;
            judgeCount[judge]++;
        }

        for (int i = 1; i <= n; ++i) {
            if (judgeCount[i] == n - 1) {
                return i;
            }
        }

        return -1;
    }
};