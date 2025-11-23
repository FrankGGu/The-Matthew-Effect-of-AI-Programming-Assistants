public class Solution {

import java.util.*;

class Solution {
    public static DataFrame createDataFrame(List<List<String>> data) {
        Map<String, List<String>> map = new HashMap<>();
        if (data.isEmpty()) {
            return new DataFrame(map);
        }
        List<String> columns = data.get(0);
        for (int i = 0; i < columns.size(); i++) {
            String col = columns.get(i);
            List<String> values = new ArrayList<>();
            for (int j = 1; j < data.size(); j++) {
                values.add(data.get(j).get(i));
            }
            map.put(col, values);
        }
        return new DataFrame(map);
    }

    static class DataFrame {
        private final Map<String, List<String>> data;

        public DataFrame(Map<String, List<String>> data) {
            this.data = data;
        }

        public Map<String, List<String>> getData() {
            return data;
        }
    }
}
}