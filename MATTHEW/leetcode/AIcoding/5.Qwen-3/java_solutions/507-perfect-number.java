public class Solution {
    public boolean checkPerfectNumber(int num) {
        if (num <= 1) {
            return false;
        }
        int sum = 1;
        int sqrtNum = (int) Math.sqrt(num);
        for (int i = 2; i <= sqrtNum; i++) {
            if (num % i == 0) {
                sum += i;
                int pair = num / i;
                if (pair != i) {
                    sum += pair;
                }
            }
        }
        return sum == num;
    }
}