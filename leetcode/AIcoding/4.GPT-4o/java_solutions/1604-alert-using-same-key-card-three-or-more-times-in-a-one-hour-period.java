import java.util.*;

public class Solution {
    public List<String> alertNames(String[] keyName, String[] keyTime) {
        Map<String, List<Integer>> map = new HashMap<>();
        List<String> result = new ArrayList<>();

        for (int i = 0; i < keyName.length; i++) {
            String name = keyName[i];
            String[] timeParts = keyTime[i].split(":");
            int time = Integer.parseInt(timeParts[0]) * 60 + Integer.parseInt(timeParts[1]);
            map.putIfAbsent(name, new ArrayList<>());
            map.get(name).add(time);
        }

        for (String name : map.keySet()) {
            List<Integer> times = map.get(name);
            Collections.sort(times);
            for (int i = 2; i < times.size(); i++) {
                if (times.get(i) - times.get(i - 2) <= 60) {
                    result.add(name);
                    break;
                }
            }
        }

        Collections.sort(result);
        return result;
    }
}