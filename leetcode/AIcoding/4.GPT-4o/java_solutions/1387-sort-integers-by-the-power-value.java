import java.util.*;

public class Solution {
    public int getKth(int lo, int hi, int k) {
        Map<Integer, Integer> powerMap = new HashMap<>();
        for (int i = lo; i <= hi; i++) {
            powerMap.put(i, powerValue(i));
        }

        List<Map.Entry<Integer, Integer>> entryList = new ArrayList<>(powerMap.entrySet());
        entryList.sort((a, b) -> a.getValue() == b.getValue() ? a.getKey() - b.getKey() : a.getValue() - b.getValue());

        return entryList.get(k - 1).getKey();
    }

    private int powerValue(int n) {
        int count = 0;
        while (n != 1) {
            if (n % 2 == 0) {
                n /= 2;
            } else {
                n = 3 * n + 1;
            }
            count++;
        }
        return count;
    }
}