import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] fraction(int numerator, int denominator) {
        List<Integer> result = new ArrayList<>();

        while (true) {
            result.add(numerator / denominator);
            int remainder = numerator % denominator;
            if (remainder == 0) {
                break;
            }
            numerator = denominator;
            denominator = remainder;
        }

        int[] arr = new int[result.size()];
        for (int i = 0; i < result.size(); i++) {
            arr[i] = result.get(i);
        }
        return arr;
    }
}