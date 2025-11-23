public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> replaceNonCoprimeNumbersInArray(int[] nums) {
        Stack<Integer> stack = new Stack<>();
        for (int num : nums) {
            while (!stack.isEmpty() && gcd(stack.peek(), num) > 1) {
                int top = stack.pop();
                num = top + num;
            }
            stack.push(num);
        }
        return new ArrayList<>(stack);
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
}