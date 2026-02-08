import java.util.HashSet;
import java.util.Set;

class Solution {
    public int distributeCandies(int[] candyType) {
        Set<Integer> distinctCandies = new HashSet<>();
        for (int candy : candyType) {
            distinctCandies.add(candy);
        }
        int uniqueCandyTypes = distinctCandies.size();
        int maxCandiesSisterCanTake = candyType.length / 2;
        return Math.min(uniqueCandyTypes, maxCandiesSisterCanTake);
    }
}