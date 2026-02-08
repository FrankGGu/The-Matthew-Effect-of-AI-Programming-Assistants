class Solution {
public:
    string predictPartyVictory(string senate) {
        int radiant = 0, dire = 0;
        queue<int> rQueue, dQueue;

        for (int i = 0; i < senate.size(); ++i) {
            if (senate[i] == 'R') {
                rQueue.push(i);
            } else {
                dQueue.push(i);
            }
        }

        while (!rQueue.empty() && !dQueue.empty()) {
            int rIndex = rQueue.front();
            int dIndex = dQueue.front();
            rQueue.pop();
            dQueue.pop();

            if (rIndex < dIndex) {
                rQueue.push(rIndex + senate.size());
            } else {
                dQueue.push(dIndex + senate.size());
            }
        }

        return rQueue.empty() ? "Dire" : "Radiant";
    }
};