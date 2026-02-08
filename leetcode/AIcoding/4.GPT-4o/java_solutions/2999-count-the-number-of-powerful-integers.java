import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int powerfulIntegers(int x, int y, int bound) {
        Set<Integer> powerfulIntegers = new HashSet<>();
        for (int i = 0; Math.pow(x, i) < bound; i++) {
            for (int j = 0; Math.pow(y, j) < bound; j++) {
                int value = (int) (Math.pow(x, i) + Math.pow(y, j));
                if (value <= bound) {
                    powerfulIntegers.add(value);
                }
                if (y == 1) break;
            }
            if (x == 1) break;
        }
        return powerfulIntegers.size();
    }
}