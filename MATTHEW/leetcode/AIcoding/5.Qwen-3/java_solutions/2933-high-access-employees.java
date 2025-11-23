public class Solution {

import java.util.*;

public class Solution {
    public List<String> highAccessEmployees(List<String[]> access_times) {
        Map<String, List<Integer>> map = new HashMap<>();
        for (String[] time : access_times) {
            String id = time[0];
            int t = Integer.parseInt(time[1]);
            map.putIfAbsent(id, new ArrayList<>());
            map.get(id).add(t);
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, List<Integer>> entry : map.entrySet()) {
            List<Integer> times = entry.getValue();
            Collections.sort(times);
            for (int i = 0; i <= times.size() - 3; i++) {
                if (times.get(i + 2) - times.get(i) < 100) {
                    result.add(entry.getKey());
                    break;
                }
            }
        }

        return result;
    }
}
}