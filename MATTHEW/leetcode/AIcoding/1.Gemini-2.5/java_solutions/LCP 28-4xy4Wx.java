import java.util.Arrays;

class Solution {
    public long procurementScheme(int[] pricesA, int[] pricesB, int target) {
        Arrays.sort(pricesA);
        Arrays.sort(pricesB);

        long count = 0;
        int i = 0; 
        int j = pricesB.length - 1; 

        while (i < pricesA.length && j >= 0) {
            if (pricesA[i] + pricesB[j] <= target) {
                count += (j + 1);
                i++; 
            } else {
                j--;
            }
        }
        return count;
    }
}