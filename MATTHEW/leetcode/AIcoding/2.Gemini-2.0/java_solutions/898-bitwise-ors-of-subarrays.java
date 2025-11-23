import java.util.HashSet;
import java.util.Set;

class Solution {
    public int subarrayBitwiseORs(int[] arr) {
        Set<Integer> result = new HashSet<>();
        Set<Integer> current = new HashSet<>();

        for (int num : arr) {
            Set<Integer> next = new HashSet<>();
            next.add(num);
            for (int prev : current) {
                next.add(prev | num);
            }
            current = next;
            result.addAll(current);
        }

        return result.size();
    }
}