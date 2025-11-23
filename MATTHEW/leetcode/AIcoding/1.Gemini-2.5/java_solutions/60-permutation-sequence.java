import java.util.ArrayList;
import java.util.List;

class Solution {
    public String getPermutation(int n, int k) {
        int[] factorials = new int[n + 1];
        List<Integer> numbers = new ArrayList<>();
        StringBuilder sb = new StringBuilder();

        factorials[0] = 1;
        for (int i = 1; i <= n; i++) {
            factorials[i] = factorials[i - 1] * i;
            numbers.add(i);
        }

        k--; 

        for (int i = 1; i <= n; i++) {
            int index = k / factorials[n - i];
            sb.append(numbers.get(index));
            numbers.remove(index);
            k %= factorials[n - i];
        }

        return sb.toString();
    }
}