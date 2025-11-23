class Solution {
public:
    vector<int> distributeRepeatingIntegers(int n, int m) {
        vector<int> result(m, 0);
        for (int i = 0; i < n; ++i) {
            result[i % m]++;
        }
        return result;
    }
};