public class Solution {

import java.util.*;

public class Solution {
    public int longestCommonPrefix(List<String> arr) {
        if (arr == null || arr.size() == 0) return 0;

        Collections.sort(arr);
        String first = arr.get(0);
        String last = arr.get(arr.size() - 1);

        int i = 0;
        while (i < first.length() && i < last.length() && first.charAt(i) == last.charAt(i)) {
            i++;
        }

        return i;
    }
}
}