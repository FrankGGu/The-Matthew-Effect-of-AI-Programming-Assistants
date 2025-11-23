class Solution {
public:
    bool reorderedPowerOf2(int N) {
        string N_str = to_string(N);
        sort(N_str.begin(), N_str.end());

        for (int i = 0; i < 31; ++i) {
            string power = to_string(1 << i);
            sort(power.begin(), power.end());
            if (power == N_str) {
                return true;
            }
        }
        return false;
    }
};