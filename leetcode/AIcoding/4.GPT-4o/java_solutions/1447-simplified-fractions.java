import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> simplifiedFractions(int n) {
        List<String> result = new ArrayList<>();
        for (int numerator = 1; numerator < n; numerator++) {
            for (int denominator = numerator + 1; denominator <= n; denominator++) {
                if (gcd(numerator, denominator) == 1) {
                    result.add(numerator + "/" + denominator);
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