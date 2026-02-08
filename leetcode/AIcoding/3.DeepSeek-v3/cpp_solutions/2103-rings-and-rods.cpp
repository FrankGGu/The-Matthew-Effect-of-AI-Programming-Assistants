class Solution {
public:
    int countPoints(string rings) {
        vector<int> rods(10, 0);
        for (int i = 0; i < rings.size(); i += 2) {
            char color = rings[i];
            int rod = rings[i + 1] - '0';
            if (color == 'R') {
                rods[rod] |= 1;
            } else if (color == 'G') {
                rods[rod] |= 2;
            } else if (color == 'B') {
                rods[rod] |= 4;
            }
        }
        int count = 0;
        for (int i = 0; i < 10; ++i) {
            if (rods[i] == 7) {
                ++count;
            }
        }
        return count;
    }
};