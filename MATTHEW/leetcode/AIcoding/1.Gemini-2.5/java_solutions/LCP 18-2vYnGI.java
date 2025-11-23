import java.util.Arrays;

class Solution {
    public int breakfastNumber(int[] staple, int[] drink, int x) {
        Arrays.sort(staple);
        Arrays.sort(drink);

        long count = 0;
        int MOD = 1_000_000_007;

        int j = drink.length - 1; 

        for (int i = 0; i < staple.length; i++) {
            while (j >= 0 && staple[i] + drink[j] > x) {
                j--;
            }

            if (j < 0) {
                break; 
            }

            count = (count + (j + 1)) % MOD;
        }

        return (int) count;
    }
}