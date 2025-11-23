import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public List<Integer> powerfulIntegers(int x, int y, int bound) {
        Set<Integer> powerfulIntegers = new HashSet<>();

        int currX = 1; // Represents x^i, starting with x^0 = 1
        // Loop for powers of x (x^i)
        while (currX <= bound) {
            int currY = 1; // Represents y^j, starting with y^0 = 1
            // Loop for powers of y (y^j)
            while (currX + currY <= bound) {
                powerfulIntegers.add(currX + currY);

                // If y is 1, y^j will always be 1. To avoid infinite loop and redundant calculations,
                // we only need to add currX + 1 once for this currX.
                if (y == 1) {
                    break;
                }
                // Calculate the next power of y
                // Check for potential overflow before multiplication, though bound is small enough
                // that currY * y will not exceed Integer.MAX_VALUE if currY <= bound.
                // However, currY * y could exceed bound, which is handled by the outer while condition.
                // The check `currY > bound / y` would prevent overflow if `y` is large and `currY` is large.
                // But since `currY` is limited by `bound`, `currY * y` will be at most `bound * 100` (max y).
                // `10^6 * 100 = 10^8`, which fits in `int`.
                currY *= y;
            }

            // If x is 1, x^i will always be 1. To avoid infinite loop and redundant calculations,
            // we only need to perform the inner loop once for x=1.
            if (x == 1) {
                break;
            }
            // Calculate the next power of x
            // Similar overflow considerations as for currY.
            currX *= x;
        }

        return new ArrayList<>(powerfulIntegers);
    }
}