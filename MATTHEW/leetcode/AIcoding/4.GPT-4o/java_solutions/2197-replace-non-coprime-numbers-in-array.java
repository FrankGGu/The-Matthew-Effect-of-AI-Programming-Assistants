import java.util.*;

public class Solution {
    public List<Integer> replaceNonCoprimes(int[] nums) {
        List<Integer> result = new ArrayList<>();
        for (int num : nums) {
            if (result.isEmpty()) {
                result.add(num);
            } else {
                int last = result.get(result.size() - 1);
                int gcd = gcd(last, num);
                while (gcd > 1) {
                    result.remove(result.size() - 1);
                    num = (last / gcd) * num;
                    if (result.isEmpty()) {
                        break;
                    }
                    last = result.get(result.size() - 1);
                    gcd = gcd(last, num);
                }
                if (gcd == 1) {
                    result.add(num);
                } else {
                    result.add((last / gcd) * num);
                }
            }
        }
        return result;
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