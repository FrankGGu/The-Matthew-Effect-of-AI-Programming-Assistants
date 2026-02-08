class Solution {
public:
    int minDominoRotations(vector<int>& tops, vector<int>& bottoms) {
        int n = tops.size();
        vector<int> countA(7, 0), countB(7, 0), same(7, 0);

        for (int i = 0; i < n; ++i) {
            countA[tops[i]]++;
            countB[bottoms[i]]++;
            if (tops[i] == bottoms[i]) {
                same[tops[i]]++;
            }
        }

        for (int x = 1; x <= 6; ++x) {
            if (countA[x] + countB[x] - same[x] == n) {
                return min(countA[x], countB[x]) - same[x];
            }
        }

        return -1;
    }
};