import java.util.HashSet;
import java.util.Set;

class Solution {
    public List<Integer> powerfulIntegers(int x, int y, int bound) {
        Set<Integer> result = new HashSet<>();
        for (int i = 0; Math.pow(x, i) < bound; i++) {
            for (int j = 0; Math.pow(y, j) < bound; j++) {
                int value = (int) (Math.pow(x, i) + Math.pow(y, j));
                if (value <= bound) {
                    result.add(value);
                }
                if (y == 1) break;
            }
            if (x == 1) break;
        }
        return new ArrayList<>(result);
    }
}