public class Solution {

import java.util.*;

public class Solution {
    public int[] findMissing(int[] students, int[] present) {
        Set<Integer> presentSet = new HashSet<>();
        for (int id : present) {
            presentSet.add(id);
        }
        List<Integer> missing = new ArrayList<>();
        for (int id : students) {
            if (!presentSet.contains(id)) {
                missing.add(id);
            }
        }
        int[] result = new int[missing.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = missing.get(i);
        }
        return result;
    }
}
}