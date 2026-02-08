import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] findEvenNumbers(int[] digits) {
        int[] counts = new int[10];
        for (int digit : digits) {
            counts[digit]++;
        }

        List<Integer> result = new ArrayList<>();

        for (int num = 100; num <= 998; num += 2) {
            int d1 = num / 100;
            int d2 = (num / 10) % 10;
            int d3 = num % 10;

            counts[d1]--;
            counts[d2]--;
            counts[d3]--;

            if (counts[d1] >= 0 && counts[d2] >= 0 && counts[d3] >= 0) {
                result.add(num);
            }

            counts[d1]++;
            counts[d2]++;
            counts[d3]++;
        }

        int[] finalResult = new int[result.size()];
        for (int i = 0; i < result.size(); i++) {
            finalResult[i] = result.get(i);
        }
        return finalResult;
    }
}