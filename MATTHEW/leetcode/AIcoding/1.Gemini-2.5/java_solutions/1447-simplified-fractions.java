import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> simplifiedFractions(int n) {
        List<String> result = new ArrayList<>();
        for (int q = 2; q <= n; q++) {
            for (int p = 1; p < q; p++) {
                if (gcd(p, q) == 1) {
                    result.add(p + "/" + q);
                }
            }
        }
        return result;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}