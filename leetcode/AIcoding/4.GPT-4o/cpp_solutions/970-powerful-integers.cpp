class Solution {
public:
    vector<int> powerfulIntegers(int x, int y, int bound) {
        set<int> result;
        for (int i = 0; pow(x, i) < bound; ++i) {
            for (int j = 0; pow(y, j) < bound; ++j) {
                int value = pow(x, i) + pow(y, j);
                if (value <= bound) {
                    result.insert(value);
                } else {
                    break;
                }
            }
            if (pow(x, i) >= bound) break;
        }
        return vector<int>(result.begin(), result.end());
    }
};