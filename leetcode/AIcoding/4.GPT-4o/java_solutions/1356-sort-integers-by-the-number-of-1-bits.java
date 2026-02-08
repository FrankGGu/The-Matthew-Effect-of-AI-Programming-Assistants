import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int[] sortByBits(int[] arr) {
        Arrays.sort(arr, new Comparator<Integer>() {
            public int compare(Integer a, Integer b) {
                int countA = Integer.bitCount(a);
                int countB = Integer.bitCount(b);
                if (countA != countB) {
                    return countA - countB;
                } else {
                    return a - b;
                }
            }
        });
        return arr;
    }
}