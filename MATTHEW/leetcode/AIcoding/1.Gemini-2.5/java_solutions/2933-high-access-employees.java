import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<String> highAccessEmployees(List<List<String>> accessTimes) {
        Map<String, List<Integer>> employeeAccessMap = new HashMap<>();

        for (List<String> access : accessTimes) {
            String name = access.get(0);
            String timeStr = access.get(1);

            String[] parts = timeStr.split(":");
            int hours = Integer.parseInt(parts[0]);
            int minutes = Integer.parseInt(parts[1]);
            int timeInMinutes = hours * 60 + minutes;

            employeeAccessMap.computeIfAbsent(name, k -> new ArrayList<>()).add(timeInMinutes);
        }

        List<String> highAccessEmployees = new ArrayList<>();

        for (Map.Entry<String, List<Integer>> entry : employeeAccessMap.entrySet()) {
            String name = entry.getKey();
            List<Integer> times = entry.getValue();

            if (times.size() < 3) {
                continue;
            }

            Collections.sort(times);

            for (int i = 0; i <= times.size() - 3; i++) {
                if (times.get(i + 2) - times.get(i) < 60) {
                    highAccessEmployees.add(name);
                    break;
                }
            }
        }

        return highAccessEmployees;
    }
}