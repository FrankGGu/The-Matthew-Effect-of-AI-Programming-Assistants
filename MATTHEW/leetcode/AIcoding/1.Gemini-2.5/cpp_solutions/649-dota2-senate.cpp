#include <string>
#include <queue>

class Solution {
public:
    std::string predictPartyVictory(std::string senate) {
        std::queue<int> radiant_q;
        std::queue<int> dire_q;
        int n = senate.length();

        for (int i = 0; i < n; ++i) {
            if (senate[i] == 'R') {
                radiant_q.push(i);
            } else {
                dire_q.push(i);
            }
        }

        while (!radiant_q.empty() && !dire_q.empty()) {
            int r_idx = radiant_q.front();
            radiant_q.pop();
            int d_idx = dire_q.front();
            dire_q.pop();

            if (r_idx < d_idx) {
                radiant_q.push(r_idx + n);
            } else {
                dire_q.push(d_idx + n);
            }
        }

        return radiant_q.empty() ? "Dire" : "Radiant";
    }
};