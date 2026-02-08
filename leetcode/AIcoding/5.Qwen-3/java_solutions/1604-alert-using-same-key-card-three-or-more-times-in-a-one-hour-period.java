public class Solution {

import java.util.*;

public class Solution {
    public List<String> alertNames(String[] keyName, String[] keyTime) {
        Map<String, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < keyName.length; i++) {
            String name = keyName[i];
            String time = keyTime[i];
            int hour = Integer.parseInt(time.split(":")[0]);
            int minute = Integer.parseInt(time.split(":")[1]);
            int totalMinutes = hour * 60 + minute;
            map.putIfAbsent(name, new ArrayList<>());
            map.get(name).add(totalMinutes);
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, List<Integer>> entry : map.entrySet()) {
            List<Integer> times = entry.getValue();
            Collections.sort(times);
            for (int i = 2; i < times.size(); i++) {
                if (times.get(i) - times.get(i - 2) <= 60) {
                    result.add(entry.getKey());
                    break;
                }
            }
        }
        return result;
    }
}
}