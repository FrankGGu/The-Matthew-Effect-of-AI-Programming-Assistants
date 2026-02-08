import java.util.Arrays;

public class Solution {
    public int maxItems(int[] price, int k) {
        Arrays.sort(price);
        int count = 0;
        for (int p : price) {
            if (k >= p) {
                k -= p;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
}