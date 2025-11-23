class Solution {
    public int minimumSum(int num) {
        for (int i = 0; i < 3; i++) {
            num = digitSum(num);
        }
        return num;
    }

    private int digitSum(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
}