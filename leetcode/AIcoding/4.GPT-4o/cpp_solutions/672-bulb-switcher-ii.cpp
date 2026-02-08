class Solution {
public:
    int flipLights(int n, int presses) {
        if (n == 0) return 0;
        if (presses == 0) return 1;

        set<pair<int, int>> states;
        for (int i = 0; i < 16; ++i) {
            int p = __builtin_popcount(i);
            if (p <= presses) {
                int bulbs = n;
                if (i & 1) bulbs -= 1; // 1st bulb
                if (i & 2) bulbs -= 1; // 2nd bulb
                if (i & 4) bulbs -= 1; // 3rd bulb
                if (i & 8) bulbs -= 1; // 4th bulb

                if (n == 1) {
                    states.insert({1, 0});
                } else if (n == 2) {
                    states.insert({2, 0});
                } else {
                    states.insert({3, 0});
                    states.insert({4, 0});
                }
            }
        }
        return states.size();
    }
};