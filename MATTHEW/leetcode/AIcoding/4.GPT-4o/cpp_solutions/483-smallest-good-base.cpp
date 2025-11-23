class Solution {
public:
    string smallestGoodBase(string n) {
        long num = stoll(n);
        for (int maxPower = 60; maxPower >= 2; --maxPower) {
            long base = pow(num, 1.0 / maxPower);
            long sum = 1, curr = 1;
            for (int i = 0; i < maxPower; ++i) {
                curr *= base;
                sum += curr;
                if (sum > num) break;
            }
            if (sum == num) return to_string(base);
        }
        return to_string(num - 1);
    }
};