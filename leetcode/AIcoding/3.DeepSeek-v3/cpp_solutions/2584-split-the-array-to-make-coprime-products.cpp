class Solution {
public:
    int findValidSplit(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> left, right;

        for (int num : nums) {
            for (int p : getPrimes(num)) {
                right[p]++;
            }
        }

        int common = 0;
        for (int i = 0; i < n - 1; ++i) {
            for (int p : getPrimes(nums[i])) {
                left[p]++;
                if (left[p] == 1) common++;
                if (left[p] == right[p]) common--;
            }
            if (common == 0) return i;
        }
        return -1;
    }

private:
    vector<int> getPrimes(int num) {
        vector<int> primes;
        for (int p = 2; p * p <= num; ++p) {
            if (num % p == 0) {
                primes.push_back(p);
                while (num % p == 0) num /= p;
            }
        }
        if (num > 1) primes.push_back(num);
        return primes;
    }
};