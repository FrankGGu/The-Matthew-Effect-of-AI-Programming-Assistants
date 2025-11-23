class Solution {
public:
    int mostFrequentPrime(vector<int>& nums) {
        unordered_map<int, int> freq;
        int maxFreq = 0, mostFreqPrime = -1;

        auto isPrime = [](int n) {
            if (n < 2) return false;
            for (int i = 2; i * i <= n; ++i) {
                if (n % i == 0) return false;
            }
            return true;
        };

        for (int num : nums) {
            if (isPrime(num)) {
                freq[num]++;
                if (freq[num] > maxFreq || (freq[num] == maxFreq && num > mostFreqPrime)) {
                    maxFreq = freq[num];
                    mostFreqPrime = num;
                }
            }
        }

        return mostFreqPrime;
    }
};