class Solution {
public:
    int maximumNumberOnes(int width, int height, int sideLength, int maxOnes) {
        vector<vector<int>> freq(sideLength, vector<int>(sideLength, 0));
        for (int i = 0; i < height; ++i) {
            for (int j = 0; j < width; ++j) {
                int x = i % sideLength;
                int y = j % sideLength;
                freq[x][y]++;
            }
        }

        vector<int> counts;
        for (int i = 0; i < sideLength; ++i) {
            for (int j = 0; j < sideLength; ++j) {
                counts.push_back(freq[i][j]);
            }
        }

        sort(counts.rbegin(), counts.rend());

        int res = 0;
        for (int i = 0; i < maxOnes; ++i) {
            res += counts[i];
        }

        return res;
    }
};