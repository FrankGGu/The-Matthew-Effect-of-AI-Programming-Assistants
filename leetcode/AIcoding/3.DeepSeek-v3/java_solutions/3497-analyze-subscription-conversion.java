import java.util.*;

class Solution {
    public double[] analyzeSubscriptionConversion(List<List<String>> events) {
        Map<String, String> userStatus = new HashMap<>();
        Map<String, Long> userStartTime = new HashMap<>();
        Map<Integer, Integer> dayCounts = new HashMap<>();
        Map<Integer, Integer> dayConversions = new HashMap<>();

        for (List<String> event : events) {
            String timestamp = event.get(0);
            String user = event.get(1);
            String action = event.get(2);

            String[] timeParts = timestamp.split("-");
            int day = Integer.parseInt(timeParts[2]);

            if (action.equals("signup")) {
                userStatus.put(user, "signup");
                userStartTime.put(user, parseTimestamp(timestamp));
            } else if (action.equals("view")) {
                if (userStatus.containsKey(user) && userStatus.get(user).equals("signup")) {
                    userStatus.put(user, "view");
                    userStartTime.put(user, parseTimestamp(timestamp));
                }
            } else if (action.equals("conversion")) {
                if (userStatus.containsKey(user) && (userStatus.get(user).equals("signup") || userStatus.get(user).equals("view"))) {
                    long startTime = userStartTime.get(user);
                    long endTime = parseTimestamp(timestamp);
                    long diffHours = (endTime - startTime) / (60 * 60 * 1000);

                    if (diffHours <= 72) {
                        dayConversions.put(day, dayConversions.getOrDefault(day, 0) + 1);
                    }
                }
            }

            if (action.equals("signup") || action.equals("view")) {
                dayCounts.put(day, dayCounts.getOrDefault(day, 0) + 1);
            }
        }

        List<Integer> days = new ArrayList<>(dayCounts.keySet());
        Collections.sort(days);
        double[] result = new double[days.size()];

        for (int i = 0; i < days.size(); i++) {
            int day = days.get(i);
            int conversions = dayConversions.getOrDefault(day, 0);
            int counts = dayCounts.getOrDefault(day, 0);
            result[i] = counts == 0 ? 0.0 : (double) conversions / counts * 100;
        }

        return result;
    }

    private long parseTimestamp(String timestamp) {
        String[] parts = timestamp.split("-| |:");
        int year = Integer.parseInt(parts[0]);
        int month = Integer.parseInt(parts[1]);
        int day = Integer.parseInt(parts[2]);
        int hour = Integer.parseInt(parts[3]);
        int minute = Integer.parseInt(parts[4]);
        int second = Integer.parseInt(parts[5]);

        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month - 1, day, hour, minute, second);
        return calendar.getTimeInMillis();
    }
}