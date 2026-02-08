class Solution {
public:
    int minOperations(int n) {
        int ans = 0;
        while (n > 0) {
            if (n % 2 == 0) {
                n /= 2;
            } else {
                if ((n + 1) % 4 == 0 && n != 3) {
                    n++;
                } else {
                    n--;
                }
            }
            ans++;
        }
        return ans;
    }
};