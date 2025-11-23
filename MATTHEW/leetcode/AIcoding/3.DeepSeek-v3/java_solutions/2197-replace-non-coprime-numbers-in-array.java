import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> replaceNonCoprimes(int[] nums) {
        List<Integer> stack = new ArrayList<>();
        for (int num : nums) {
            int current = num;
            while (!stack.isEmpty()) {
                int last = stack.get(stack.size() - 1);
                int gcd = gcd(last, current);
                if (gcd == 1) {
                    break;
                }
                current = (int) ((long) last * current / gcd);
                stack.remove(stack.size() - 1);
            }
            stack.add(current);
        }
        return stack;
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