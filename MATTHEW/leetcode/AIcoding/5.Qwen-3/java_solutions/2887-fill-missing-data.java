public class Solution {

import java.util.*;

class Solution {
    public void fillMissingData(List<Map<String, Object>> data) {
        Set<String> keys = new HashSet<>();
        for (Map<String, Object> item : data) {
            keys.addAll(item.keySet());
        }

        for (Map<String, Object> item : data) {
            for (String key : keys) {
                if (!item.containsKey(key)) {
                    item.put(key, null);
                }
            }
        }
    }
}
}