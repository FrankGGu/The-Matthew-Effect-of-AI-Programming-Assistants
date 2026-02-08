import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> maximumEvenSplit(int finalSum) {
        List<Integer> result = new ArrayList<>();
        if (finalSum % 2 != 0) return result;

        for (int i = 2; finalSum >= i; i += 2) {
            result.add(i);
            finalSum -= i;
        }

        if (finalSum > 0) {
            result.set(result.size() - 1, result.get(result.size() - 1) + finalSum);
        }

        return result;
    }
}