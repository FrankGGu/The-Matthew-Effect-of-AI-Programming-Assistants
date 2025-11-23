public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean hasGroupsSizeX(int[] deck) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int card : deck) {
            count.put(card, count.getOrDefault(card, 0) + 1);
        }

        int gcd = 0;
        for (int v : count.values()) {
            gcd = gcd(gcd, v);
        }

        return gcd >= 2;
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