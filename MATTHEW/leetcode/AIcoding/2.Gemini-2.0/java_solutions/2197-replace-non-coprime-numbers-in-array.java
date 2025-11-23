import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> replaceNonCoprime(int[] nums) {
        List<Integer> result = new ArrayList<>();
        for (int num : nums) {
            while (!result.isEmpty()) {
                int gcd = gcd(result.get(result.size() - 1), num);
                if (gcd == 1) {
                    break;
                }
                num = lcm(result.remove(result.size() - 1), num);
            }
            result.add(num);
        }
        return result;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    private int lcm(int a, int b) {
        return a / gcd(a, b) * b;
    }
}