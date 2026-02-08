class Solution {
public:
    string longestDupSubstring(string S) {
        int n = S.size();
        int left = 1, right = n;
        string res;
        vector<int> nums(n);
        for (int i = 0; i < n; ++i) {
            nums[i] = S[i] - 'a';
        }
        long modulus = (long)pow(2, 32);
        int base = 26;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int start = search(mid, base, modulus, nums);
            if (start != -1) {
                res = S.substr(start, mid);
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return res;
    }

    int search(int L, int base, long modulus, vector<int>& nums) {
        int n = nums.size();
        long h = 0;
        for (int i = 0; i < L; ++i) {
            h = (h * base + nums[i]) % modulus;
        }
        unordered_set<long> seen;
        seen.insert(h);
        long aL = 1;
        for (int i = 1; i <= L; ++i) {
            aL = (aL * base) % modulus;
        }
        for (int start = 1; start < n - L + 1; ++start) {
            h = (h * base - nums[start - 1] * aL % modulus + modulus) % modulus;
            h = (h + nums[start + L - 1]) % modulus;
            if (seen.count(h)) {
                return start;
            }
            seen.insert(h);
        }
        return -1;
    }
};