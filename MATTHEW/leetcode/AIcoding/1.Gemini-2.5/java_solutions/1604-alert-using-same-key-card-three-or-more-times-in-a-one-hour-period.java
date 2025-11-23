import java.util.*;

class Solution {
    public List<String> alertNames(String[] keyName, String[] keyTime) {
        Map<String, List<Integer>> employeeSwipeTimes = new HashMap<>();

        for (int i = 0; i < keyName.length; i++) {
            String name = keyName[i];
            String timeStr = keyTime[i];

            String[] parts = timeStr.split(":");
            int hours = Integer.parseInt(parts[0]);
            int minutes = Integer.parseInt(parts[1]);
            int totalMinutes = hours * 60 + minutes;

            employeeSwipeTimes.computeIfAbsent(name, k -> new ArrayList<>()).add(totalMinutes);
        }

        List<String> alertEmployees = new ArrayList<>();

        for (Map.Entry<String, List<Integer>> entry : employeeSwipeTimes.entrySet()) {
            String name = entry.getKey();
            List<Integer> times = entry.getValue();

            Collections.sort(times);

            if (times.size() < 3) {
                continue;
            }

            for (int i = 0; i <= times.size() - 3; i++) {
                int time1 = times.get(i);
                int time3 = times.get(i + 2);

                if (time3 - time1 <= 60) {
                    alertEmployees.add(name);
                    break; 
                }
            }
        }

        Collections.sort(alertEmployees);
        return alertEmployees;
    }
}