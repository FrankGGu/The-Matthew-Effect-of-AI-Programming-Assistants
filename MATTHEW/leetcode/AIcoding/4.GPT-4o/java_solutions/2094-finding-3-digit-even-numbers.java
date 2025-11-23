import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> findEvenNumbers(int[] digits) {
        List<Integer> result = new ArrayList<>();
        boolean[] used = new boolean[10];

        for (int digit : digits) {
            used[digit] = true;
        }

        for (int i = 100; i < 1000; i++) {
            if (i % 2 == 0) {
                int[] count = new int[10];
                int n = i;
                boolean valid = true;

                while (n > 0) {
                    count[n % 10]++;
                    n /= 10;
                }

                for (int j = 0; j < 10; j++) {
                    if (count[j] > 0 && !used[j]) {
                        valid = false;
                        break;
                    }
                }

                if (valid) {
                    result.add(i);
                }
            }
        }

        return result;
    }
}