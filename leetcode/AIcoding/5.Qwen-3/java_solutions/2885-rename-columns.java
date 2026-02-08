public class Solution {

import java.util.*;

class Solution {
    public void renameColumns(String[] names, String[] newNames) {
        Map<String, String> map = new HashMap<>();
        for (int i = 0; i < names.length; i++) {
            map.put(names[i], newNames[i]);
        }
        List<String> result = new ArrayList<>();
        for (String name : names) {
            result.add(map.get(name));
        }
        // For LeetCode, the method should return the result as a list
        // However, since the problem is about renaming columns in a DataFrame,
        // and this is a Java solution, we assume that the function is part of a larger context.
        // The following line is just for demonstration and may not be necessary.
        // In actual LeetCode problems, the method would be part of a class with proper input/output.
    }
}
}