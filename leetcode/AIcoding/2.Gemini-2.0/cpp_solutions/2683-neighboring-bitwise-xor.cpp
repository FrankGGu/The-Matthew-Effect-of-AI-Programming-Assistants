class Solution {
public:
    bool doesValidArrayExist(vector<int>& derived) {
        int n = derived.size();
        int xor_sum = 0;
        for (int i = 0; i < n; ++i) {
            xor_sum ^= derived[i];
        }
        return xor_sum == 0;
    }
};