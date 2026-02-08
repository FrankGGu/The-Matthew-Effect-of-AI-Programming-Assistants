public class Solution {
    public int minimumSum(int num) {
        int sum = 0;
        int count = 0;
        int current = 0;
        while (count < num) {
            current++;
            if (current % 10 == num % 10) {
                sum += current;
                count++;
            }
        }
        return sum;
    }
}