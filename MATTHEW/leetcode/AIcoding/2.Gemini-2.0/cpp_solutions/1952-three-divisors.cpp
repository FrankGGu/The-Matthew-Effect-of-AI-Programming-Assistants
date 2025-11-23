class Solution {
public:
    bool isThree(int n) {
        if (n <= 3) return false;
        int count = 0;
        for (int i = 1; i * i <= n; ++i) {
            if (n % i == 0) {
                if (i * i == n) {
                    count++;
                } else {
                    count += 2;
                }
            }
        }
        return count == 3;
    }
};