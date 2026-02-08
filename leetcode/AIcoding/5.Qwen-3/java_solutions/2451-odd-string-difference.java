public class Solution {

import java.util.*;

public class Solution {
    public List<String> oddString(Map<String, List<String>> mapping) {
        Map<String, List<String>> diffMap = new HashMap<>();

        for (Map.Entry<String, List<String>> entry : mapping.entrySet()) {
            String key = entry.getKey();
            List<String> values = entry.getValue();

            StringBuilder diffBuilder = new StringBuilder();
            for (int i = 1; i < values.size(); i++) {
                int diff = values.get(i).charAt(0) - values.get(i - 1).charAt(0);
                diffBuilder.append(diff).append(",");
            }

            String diffKey = diffBuilder.toString();
            diffMap.putIfAbsent(diffKey, new ArrayList<>());
            diffMap.get(diffKey).add(key);
        }

        for (List<String> list : diffMap.values()) {
            if (list.size() == 1) {
                return list;
            }
        }

        return new ArrayList<>();
    }
}
}