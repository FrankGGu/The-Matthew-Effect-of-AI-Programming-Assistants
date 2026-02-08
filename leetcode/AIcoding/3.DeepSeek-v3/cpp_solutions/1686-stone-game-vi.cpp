using namespace std;

class Solution {
public:
    int stoneGameVI(vector<int>& aliceValues, vector<int>& bobValues) {
        int n = aliceValues.size();
        vector<int> idx(n);
        for (int i = 0; i < n; i++) {
            idx[i] = i;
        }
        sort(idx.begin(), idx.end(), [&](int i, int j) {
            return (aliceValues[i] + bobValues[i]) > (aliceValues[j] + bobValues[j]);
        });

        int a = 0, b = 0;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                a += aliceValues[idx[i]];
            } else {
                b += bobValues[idx[i]];
            }
        }

        if (a > b) return 1;
        else if (a < b) return -1;
        return 0;
    }
};