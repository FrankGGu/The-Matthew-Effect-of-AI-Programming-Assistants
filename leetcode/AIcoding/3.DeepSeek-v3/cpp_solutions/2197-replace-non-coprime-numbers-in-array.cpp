class Solution {
public:
    vector<int> replaceNonCoprimes(vector<int>& nums) {
        vector<int> res;
        for (int num : nums) {
            int current = num;
            while (!res.empty()) {
                int last = res.back();
                int gcd_val = gcd(last, current);
                if (gcd_val == 1) break;
                res.pop_back();
                current = (long long)last * current / gcd_val;
            }
            res.push_back(current);
        }
        return res;
    }
};