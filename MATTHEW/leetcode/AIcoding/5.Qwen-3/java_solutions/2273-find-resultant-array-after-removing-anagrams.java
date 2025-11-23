public class Solution {

import java.util.*;

public class Solution {
    public List<String> removeAnagrams(String[] nums) {
        List<String> result = new ArrayList<>();
        String prev = "";
        for (String num : nums) {
            char[] chars = num.toCharArray();
            Arrays.sort(chars);
            String sorted = new String(chars);
            if (!sorted.equals(prev)) {
                result.add(num);
                prev = sorted;
            }
        }
        return result;
    }
}
}