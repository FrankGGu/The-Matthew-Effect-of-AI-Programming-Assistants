import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int getKth(int lo, int hi, int k) {
        Map<Integer, Integer> powerMap = new HashMap<>();
        int[][] arr = new int[hi - lo + 1][2];
        for (int i = lo; i <= hi; i++) {
            arr[i - lo][0] = i;
            arr[i - lo][1] = getPower(i, powerMap);
        }
        Arrays.sort(arr, (a, b) -> {
            if (a[1] != b[1]) {
                return a[1] - b[1];
            } else {
                return a[0] - b[0];
            }
        });
        return arr[k - 1][0];
    }

    private int getPower(int n, Map<Integer, Integer> powerMap) {
        if (n == 1) {
            return 0;
        }
        if (powerMap.containsKey(n)) {
            return powerMap.get(n);
        }
        int power;
        if (n % 2 == 0) {
            power = 1 + getPower(n / 2, powerMap);
        } else {
            power = 1 + getPower(3 * n + 1, powerMap);
        }
        powerMap.put(n, power);
        return power;
    }
}