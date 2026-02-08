class Solution {
public:
    bool isHappy(int n) {
        std::unordered_set<int> seen;
        while (n != 1 && seen.find(n) == seen.end()) {
            seen.insert(n);
            int next_n = 0;
            while (n > 0) {
                int digit = n % 10;
                next_n += digit * digit;
                n /= 10;
            }
            n = next_n;
        }
        return n == 1;
    }
};