import java.util.HashSet;
import java.util.Set;

class Solution {
    public int subarrayBitwiseORs(int[] arr) {
        Set<Integer> totalUniqueORs = new HashSet<>();
        Set<Integer> currentORs = new HashSet<>();

        for (int num : arr) {
            Set<Integer> newCurrentORs = new HashSet<>();

            newCurrentORs.add(num);

            for (int prevOR : currentORs) {
                newCurrentORs.add(prevOR | num);
            }

            totalUniqueORs.addAll(newCurrentORs);

            currentORs = newCurrentORs;
        }

        return totalUniqueORs.size();
    }
}