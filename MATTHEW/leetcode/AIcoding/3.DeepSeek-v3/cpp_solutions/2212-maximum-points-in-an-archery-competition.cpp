class Solution {
public:
    vector<int> maximumBobPoints(int numArrows, vector<int>& aliceArrows) {
        vector<int> res(12, 0);
        int maxScore = 0;

        for (int mask = 0; mask < (1 << 12); ++mask) {
            int arrows = 0, score = 0;
            vector<int> bobArrows(12, 0);

            for (int i = 0; i < 12; ++i) {
                if (mask & (1 << i)) {
                    arrows += aliceArrows[i] + 1;
                    bobArrows[i] = aliceArrows[i] + 1;
                    score += i;
                }
            }

            if (arrows <= numArrows && score > maxScore) {
                maxScore = score;
                res = bobArrows;
                res[0] += numArrows - arrows;
            }
        }

        return res;
    }
};