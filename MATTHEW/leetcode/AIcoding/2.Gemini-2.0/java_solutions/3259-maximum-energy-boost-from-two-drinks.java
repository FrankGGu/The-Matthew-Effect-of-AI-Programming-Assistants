import java.util.Arrays;

class Solution {
    public int maxEnergyBoost(int[] drinks) {
        Arrays.sort(drinks);
        return drinks[drinks.length - 1] + drinks[drinks.length - 2];
    }
}