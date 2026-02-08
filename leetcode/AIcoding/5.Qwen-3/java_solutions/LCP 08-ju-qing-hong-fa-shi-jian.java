public class Solution {

import java.util.*;

public class Solution {
    public List<String> alertNames(String[] keyName, String[] keyTimeIps) {
        Map<String, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < keyName.length; i++) {
            String name = keyName[i];
            String timeIp = keyTimeIps[i];
            String[] parts = timeIp.split(":");
            int hour = Integer.parseInt(parts[0]);
            int minute = Integer.parseInt(parts[1]);
            int totalMinutes = hour * 60 + minute;
            map.putIfAbsent(name, new ArrayList<>());
            map.get(name).add(totalMinutes);
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, List<Integer>> entry : map.entrySet()) {
            String name = entry.getKey();
            List<Integer> times = entry.getValue();
            Collections.sort(times);
            boolean alert = false;
            for (int i = 2; i < times.size(); i++) {
                if (times.get(i) - times.get(i - 2) <= 100) {
                    alert = true;
                    break;
                }
            }
            if (alert) {
                result.add(name);
            }
        }
        return result;
    }
}
}