class Solution {
    public int sumFourDivisors(int[] nums) {
        int sum = 0;
        for (int num : nums) {
            int count = 0;
            int divSum = 0;
            for (int i = 1; i * i <= num; i++) {
                if (num % i == 0) {
                    if (i * i == num) {
                        count++;
                        divSum += i;
                    } else {
                        count += 2;
                        divSum += i + num / i;
                    }
                }
            }
            if (count == 4) {
                sum += divSum;
            }
        }
        return sum;
    }
}