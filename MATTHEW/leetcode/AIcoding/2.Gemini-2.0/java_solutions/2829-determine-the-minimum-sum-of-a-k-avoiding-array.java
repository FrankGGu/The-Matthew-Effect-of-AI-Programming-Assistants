import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minSum(int n, int k) {
        Set<Integer> used = new HashSet<>();
        int sum = 0;
        int num = 1;

        for (int i = 0; i < n; i++) {
            while (used.contains(num)) {
                num++;
            }
            sum += num;
            used.add(k - num);
            num++;
        }

        return sum;
    }
}