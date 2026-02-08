class Solution {
public:
    int createSortedArray(vector<int>& instructions) {
        const int MOD = 1e9 + 7;
        int max_val = *max_element(instructions.begin(), instructions.end());
        vector<int> count(max_val + 1, 0);
        long long result = 0;
        long long total = 0;

        for (int num : instructions) {
            long long left = 0, right = 0;

            for (int i = 1; i < num; ++i) {
                left += count[i];
            }
            for (int i = num + 1; i <= max_val; ++i) {
                right += count[i];
            }

            result = (result + min(left, right)) % MOD;
            count[num]++;
        }

        return result;
    }
};