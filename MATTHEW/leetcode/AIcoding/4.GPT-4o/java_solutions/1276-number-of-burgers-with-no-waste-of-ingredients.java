import java.util.Arrays;

class Solution {
    public List<Integer> numOfBurgers(int tomatoSlices, int cheeseSlices) {
        int maxJumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
        int maxSmall = cheeseSlices - maxJumbo;

        if (maxJumbo < 0 || maxSmall < 0 || 2 * (maxJumbo + maxSmall) + 4 * (maxJumbo) != tomatoSlices) {
            return Arrays.asList();
        }

        return Arrays.asList(maxJumbo, maxSmall);
    }
}