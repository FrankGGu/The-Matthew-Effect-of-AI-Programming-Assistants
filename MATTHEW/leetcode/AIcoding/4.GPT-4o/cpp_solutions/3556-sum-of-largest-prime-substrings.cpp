class Solution {
public:
    int largestPrimeSubstring(string s) {
        int maxPrime = 0;
        for (int i = 0; i < s.size(); ++i) {
            for (int j = i + 1; j <= s.size(); ++j) {
                string sub = s.substr(i, j - i);
                int num = stoi(sub);
                if (isPrime(num)) {
                    maxPrime = max(maxPrime, num);
                }
            }
        }
        return maxPrime;
    }

private:
    bool isPrime(int n) {
        if (n < 2) return false;
        for (int i = 2; i * i <= n; ++i) {
            if (n % i == 0) return false;
        }
        return true;
    }
};