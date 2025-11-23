class Solution {
public:
    const int MOD = 1337;

    int superPow(int a, vector<int>& b) {
        if (b.empty()) return 1;
        int last_digit = b.back();
        b.pop_back();
        int part1 = myPow(a, last_digit);
        int part2 = myPow(superPow(a, b), 10);
        return (part1 * part2) % MOD;
    }

private:
    int myPow(int a, int k) {
        a %= MOD;
        int result = 1;
        for (int i = 0; i < k; ++i) {
            result = (result * a) % MOD;
        }
        return result;
    }
};