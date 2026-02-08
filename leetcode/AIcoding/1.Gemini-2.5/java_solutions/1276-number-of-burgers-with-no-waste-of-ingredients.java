import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> numOfBurgers(int tomatoSlices, int cheeseSlices) {
        if (tomatoSlices % 2 != 0) {
            return new ArrayList<>();
        }

        int jumboBurgers = (tomatoSlices - 2 * cheeseSlices) / 2;
        int smallBurgers = (4 * cheeseSlices - tomatoSlices) / 2;

        if (jumboBurgers >= 0 && smallBurgers >= 0) {
            return List.of(jumboBurgers, smallBurgers);
        } else {
            return new ArrayList<>();
        }
    }
}