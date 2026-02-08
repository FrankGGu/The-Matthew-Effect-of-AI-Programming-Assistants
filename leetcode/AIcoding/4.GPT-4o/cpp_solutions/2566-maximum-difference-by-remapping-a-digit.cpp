class Solution {
public:
    int minOperations(int n) {
        int ans = 0, d = 1;
        while (n > 0) {
            ans += (n % 10) * d;
            n /= 10;
            d *= 10;
        }
        return ans;
    }

    int maxOperations(int n) {
        int ans = 0, d = 1, maxDigit = 0;
        while (n > 0) {
            maxDigit = max(maxDigit, n % 10);
            n /= 10;
        }
        n = maxDigit;
        while (n > 0) {
            ans += (9 - (n % 10)) * d;
            n /= 10;
            d *= 10;
        }
        return ans;
    }

    int maximumDifference(string num) {
        int minNum = minOperations(stoi(num));
        int maxNum = maxOperations(stoi(num));
        return maxNum - minNum;
    }
};