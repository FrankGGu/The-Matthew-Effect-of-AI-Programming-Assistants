class Solution {
public:
    int getLucky(string s, int k) {
        string converted;
        for (char c : s) {
            converted += to_string(c - 'a' + 1);
        }
        int sum = 0;
        for (char c : converted) {
            sum += c - '0';
        }
        for (int i = 1; i < k; i++) {
            int newSum = 0;
            while (sum > 0) {
                newSum += sum % 10;
                sum /= 10;
            }
            sum = newSum;
        }
        return sum;
    }
};