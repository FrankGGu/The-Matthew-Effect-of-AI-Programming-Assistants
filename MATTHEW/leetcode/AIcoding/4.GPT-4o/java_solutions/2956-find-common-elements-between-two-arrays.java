import java.util.HashSet;
import java.util.Set;

class Solution {
    public int[] findCommonElements(int[] array1, int[] array2) {
        Set<Integer> set1 = new HashSet<>();
        for (int num : array1) {
            set1.add(num);
        }

        Set<Integer> common = new HashSet<>();
        for (int num : array2) {
            if (set1.contains(num)) {
                common.add(num);
            }
        }

        int[] result = new int[common.size()];
        int index = 0;
        for (int num : common) {
            result[index++] = num;
        }

        return result;
    }
}