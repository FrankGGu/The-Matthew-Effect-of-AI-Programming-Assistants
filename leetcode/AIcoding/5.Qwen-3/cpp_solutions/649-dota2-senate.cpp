#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    string predictPartyVictory(string senate) {
        int n = senate.size();
        queue<int> q;
        int radiant = 0, dire = 0;

        for (int i = 0; i < n; ++i) {
            if (senate[i] == 'R') {
                q.push(i);
                radiant++;
            } else {
                q.push(i);
                dire++;
            }
        }

        while (radiant > 0 && dire > 0) {
            int current = q.front();
            q.pop();

            if (senate[current] == 'R') {
                if (dire > 0) {
                    q.push(current);
                    dire--;
                }
            } else {
                if (radiant > 0) {
                    q.push(current);
                    radiant--;
                }
            }
        }

        return radiant > 0 ? "Radiant" : "Dire";
    }
};