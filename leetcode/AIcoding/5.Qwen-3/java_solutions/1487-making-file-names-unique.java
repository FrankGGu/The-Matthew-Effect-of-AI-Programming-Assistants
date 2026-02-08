public class Solution {

import java.util.*;

public class Solution {
    public String[] getFolderNames(String[] names) {
        Map<String, Integer> map = new HashMap<>();
        List<String> result = new ArrayList<>();
        for (String name : names) {
            if (!map.containsKey(name)) {
                result.add(name);
                map.put(name, 1);
            } else {
                int count = map.get(name);
                String newName = name + "." + count;
                while (map.containsKey(newName)) {
                    count++;
                    newName = name + "." + count;
                }
                result.add(newName);
                map.put(name, count + 1);
                map.put(newName, 1);
            }
        }
        return result.toArray(new String[0]);
    }
}
}