class Solution {
public:
    bool isHarshad(int num) {
        int sum = 0, n = num;
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        return num % sum == 0;
    }
};