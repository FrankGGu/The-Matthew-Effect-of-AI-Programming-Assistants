import java.util.*;

class Solution {
    public List<String> alertNames(String[] keyName, String[] keyTime) {
        Map<String, List<Integer>> timeMap = new HashMap<>();
        for (int i = 0; i < keyName.length; i++) {
            String name = keyName[i];
            String time = keyTime[i];
            int hour = Integer.parseInt(time.substring(0, 2));
            int minute = Integer.parseInt(time.substring(3, 5));
            int totalMinutes = hour * 60 + minute;
            timeMap.computeIfAbsent(name, k -> new ArrayList<>()).add(totalMinutes);
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, List<Integer>> entry : timeMap.entrySet()) {
            String name = entry.getKey();
            List<Integer> times = entry.getValue();
            Collections.sort(times);
            for (int i = 0; i < times.size() - 2; i++) {
                if (times.get(i + 2) - times.get(i) <= 60) {
                    result.add(name);
                    break;
                }
            }
        }

        Collections.sort(result);
        return result;
    }
}