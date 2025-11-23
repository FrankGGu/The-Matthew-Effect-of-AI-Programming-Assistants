import java.util.HashSet;
import java.util.Set;

class Solution {
    public int distinctIntegers(int[] nums) {
        Set<Integer> distinctNumbers = new HashSet<>();

        for (int num : nums) {
            distinctNumbers.add(num);

            int reversedNum = 0;
            int temp = num;
            while (temp > 0) {
                int digit = temp % 10;
                reversedNum = reversedNum * 10 + digit;
                temp /= 10;
            }
            distinctNumbers.add(reversedNum);
        }

        return distinctNumbers.size();
    }
}