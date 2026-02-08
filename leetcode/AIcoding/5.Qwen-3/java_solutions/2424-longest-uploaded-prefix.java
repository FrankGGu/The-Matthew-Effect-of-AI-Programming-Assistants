public class Solution {

import java.util.*;

public class Solution {
    public int longestUploadedPrefix(int n, List<Integer> files) {
        Set<Integer> uploaded = new HashSet<>();
        int max = 0;
        for (int file : files) {
            uploaded.add(file);
            while (uploaded.contains(max + 1)) {
                max++;
            }
        }
        return max;
    }
}
}