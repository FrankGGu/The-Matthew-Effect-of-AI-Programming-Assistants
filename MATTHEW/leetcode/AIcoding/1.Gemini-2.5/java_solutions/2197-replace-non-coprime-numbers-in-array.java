import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> replaceNonCoprimes(int[] nums) {
        List<Long> stack = new ArrayList<>();

        for (int num : nums) {
            long current = num;

            while (!stack.isEmpty()) {
                long top = stack.get(stack.size() - 1);
                long commonDivisor = gcd(top, current);

                if (commonDivisor == 1) {
                    break;
                } else {
                    stack.remove(stack.size() - 1);
                    current = lcm(top, current);
                }
            }
            stack.add(current);
        }

        List<Integer> result = new ArrayList<>();
        for (long val : stack) {
            result.add((int) val);
        }
        return result;
    }

    private long gcd(long a, long b) {
        while (b != 0) {
            long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    private long lcm(long a, long b) {
        return (a / gcd(a, b)) * b;
    }
}