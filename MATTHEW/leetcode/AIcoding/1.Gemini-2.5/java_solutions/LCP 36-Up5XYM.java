import java.util.HashMap;
import java.util.Map;
import java.util.Collection;
import java.util.Iterator;

class Solution {
    public boolean hasGroupsSizeX(int[] deck) {
        if (deck.length < 2) {
            return false;
        }

        Map<Integer, Integer> counts = new HashMap<>();
        for (int card : deck) {
            counts.put(card, counts.getOrDefault(card, 0) + 1);
        }

        Collection<Integer> frequencies = counts.values();
        Iterator<Integer> it = frequencies.iterator();

        int resultGcd = it.next(); 

        while (it.hasNext()) {
            resultGcd = gcd(resultGcd, it.next());
        }

        return resultGcd >= 2;
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