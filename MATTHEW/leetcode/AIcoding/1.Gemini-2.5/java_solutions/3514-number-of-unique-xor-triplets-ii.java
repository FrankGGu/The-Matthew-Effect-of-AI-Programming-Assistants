import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;

class Solution {
    public int uniqueXORTriplets(int[] nums) {
        Set<Integer> distinctNumbers = new HashSet<>();
        for (int num : nums) {
            distinctNumbers.add(num);
        }

        List<Integer> uniqueList = new ArrayList<>(distinctNumbers);
        int count = 0;

        for (int i = 0; i < uniqueList.size(); i++) {
            int a = uniqueList.get(i);
            for (int j = i + 1; j < uniqueList.size(); j++) {
                int b = uniqueList.get(j);

                int c = a ^ b;

                if (distinctNumbers.contains(c) && c != a && c != b) {
                    count++;
                }
            }
        }

        return count / 3;
    }
}