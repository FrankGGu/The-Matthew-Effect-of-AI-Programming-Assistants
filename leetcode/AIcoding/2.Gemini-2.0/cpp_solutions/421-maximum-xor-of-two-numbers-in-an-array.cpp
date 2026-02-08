class Solution {
public:
    int findMaximumXOR(vector<int>& nums) {
        int mask = 0;
        int max_xor = 0;
        unordered_set<int> prefix;

        for (int i = 31; i >= 0; i--) {
            mask |= (1 << i);
            prefix.clear();
            for (int num : nums) {
                prefix.insert(num & mask);
            }

            int temp = max_xor | (1 << i);
            for (int p : prefix) {
                if (prefix.count(temp ^ p)) {
                    max_xor = temp;
                    break;
                }
            }
        }

        return max_xor;
    }
};