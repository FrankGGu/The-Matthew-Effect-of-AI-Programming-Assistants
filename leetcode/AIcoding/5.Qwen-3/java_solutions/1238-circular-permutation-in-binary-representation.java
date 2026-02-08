public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> circularPermutation(int n, int start) {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < (1 << n); i++) {
            result.add(i ^ (i >> 1));
        }
        int index = result.indexOf(start);
        List<Integer> rotated = new ArrayList<>();
        for (int i = index; i < result.size(); i++) {
            rotated.add(result.get(i));
        }
        for (int i = 0; i < index; i++) {
            rotated.add(result.get(i));
        }
        return rotated;
    }
}
}