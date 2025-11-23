import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private Map<Integer, Integer> memo;

    public int getKth(int lo, int hi, int k) {
        memo = new HashMap<>();
        List<int[]> numbersWithPower = new ArrayList<>();

        for (int i = lo; i <= hi; i++) {
            int power = calculatePower(i);
            numbersWithPower.add(new int[]{i, power});
        }

        Collections.sort(numbersWithPower, (a, b) -> {
            if (a[1] != b[1]) {
                return a[1] - b[1];
            } else {
                return a[0] - b[0];
            }
        });

        return numbersWithPower.get(k - 1)[0];
    }

    private int calculatePower(int n) {
        if (n == 1) {
            return 0;
        }
        if (memo.containsKey(n)) {
            return memo.get(n);
        }

        int steps;
        if (n % 2 == 0) {
            steps = 1 + calculatePower(n / 2);
        } else {
            steps = 1 + calculatePower(3 * n + 1);
        }
        memo.put(n, steps);
        return steps;
    }
}