class Solution {
public:
    bool canArrange(vector<int>& arr, int k) {
        vector<int> mod(k, 0);
        for (int num : arr) {
            int remainder = (num % k + k) % k;
            mod[remainder]++;
        }
        if (mod[0] % 2 != 0) {
            return false;
        }
        for (int i = 1; i <= k / 2; ++i) {
            if (mod[i] != mod[k - i]) {
                return false;
            }
        }
        return true;
    }
};