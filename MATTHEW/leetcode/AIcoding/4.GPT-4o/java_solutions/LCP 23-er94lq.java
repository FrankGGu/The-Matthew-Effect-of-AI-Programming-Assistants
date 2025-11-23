import java.util.*;

public class Solution {
    public List<Integer> getSortedArray(int n) {
        List<Integer> result = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            result.add(i);
        }
        return result;
    }

    public List<Integer> constructArray(int n, int k) {
        List<Integer> result = new ArrayList<>();
        for (int i = 1; i <= n - k; i++) {
            result.add(i);
        }
        for (int i = n; i > n - k; i--) {
            result.add(i);
        }
        for (int i = 1; i < k; i++) {
            result.add(n - i);
        }
        return result;
    }
}