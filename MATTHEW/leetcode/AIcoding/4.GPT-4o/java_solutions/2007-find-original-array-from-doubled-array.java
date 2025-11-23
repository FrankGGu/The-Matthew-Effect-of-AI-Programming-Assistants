import java.util.Arrays;
import java.util.HashMap;

public class Solution {
    public int[] findOriginalArray(int[] changed) {
        if (changed.length % 2 != 0) return new int[0];
        Arrays.sort(changed);
        HashMap<Integer, Integer> countMap = new HashMap<>();
        for (int num : changed) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        int[] original = new int[changed.length / 2];
        int index = 0;

        for (int num : changed) {
            if (countMap.get(num) == 0) continue;
            countMap.put(num, countMap.get(num) - 1);
            int doubled = num * 2;
            if (countMap.getOrDefault(doubled, 0) == 0) return new int[0];
            countMap.put(doubled, countMap.get(doubled) - 1);
            original[index++] = num;
        }
        return original;
    }
}