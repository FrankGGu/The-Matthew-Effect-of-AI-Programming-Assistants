import java.util.Arrays;

public class Solution {
    public int[] redistributeApples(int[] boxes) {
        int totalApples = Arrays.stream(boxes).sum();
        int n = boxes.length;
        int[] result = new int[n];
        Arrays.fill(result, totalApples / n);

        for (int i = 0; i < totalApples % n; i++) {
            result[i]++;
        }

        return result;
    }
}