#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int minTimeToType(string keyboard, string word) {
        unordered_map<char, int> keyPos;
        for (int i = 0; i < keyboard.size(); ++i) {
            keyPos[keyboard[i]] = i;
        }

        int time = 0;
        int currentPos = 0;
        for (char c : word) {
            int targetPos = keyPos[c];
            time += abs(targetPos - currentPos);
            time += 1;
            currentPos = targetPos;
        }
        return time;
    }
};