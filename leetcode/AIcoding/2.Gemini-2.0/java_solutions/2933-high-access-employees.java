import java.util.*;

class Solution {
    public List<String> findHighAccessEmployees(List<List<String>> access_times) {
        Map<String, List<Integer>> employeeTimes = new HashMap<>();
        for (List<String> access : access_times) {
            String employee = access.get(0);
            int time = Integer.parseInt(access.get(1));
            employeeTimes.computeIfAbsent(employee, k -> new ArrayList<>()).add(time);
        }

        List<String> highAccess = new ArrayList<>();
        for (Map.Entry<String, List<Integer>> entry : employeeTimes.entrySet()) {
            String employee = entry.getKey();
            List<Integer> times = entry.getValue();
            Collections.sort(times);
            for (int i = 0; i < times.size() - 2; i++) {
                if (times.get(i + 2) - times.get(i) < 100) {
                    highAccess.add(employee);
                    break;
                }
            }
        }

        return highAccess;
    }
}