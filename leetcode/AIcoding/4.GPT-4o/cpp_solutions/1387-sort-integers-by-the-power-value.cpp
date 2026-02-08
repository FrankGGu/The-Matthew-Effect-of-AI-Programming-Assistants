class Solution {
public:
    int getKth(int lo, int hi, int k) {
        vector<pair<int, int>> powerValues;
        for (int i = lo; i <= hi; ++i) {
            int power = calculatePower(i);
            powerValues.emplace_back(power, i);
        }
        sort(powerValues.begin(), powerValues.end());
        return powerValues[k - 1].second;
    }

private:
    int calculatePower(int x) {
        int power = 0;
        while (x != 1) {
            if (x % 2 == 0) {
                x /= 2;
            } else {
                x = 3 * x + 1;
            }
            power++;
        }
        return power;
    }
};