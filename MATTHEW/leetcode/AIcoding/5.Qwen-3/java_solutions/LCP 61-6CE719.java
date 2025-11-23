public class Solution {

import java.util.*;

public class Solution {
    public List<String> temperatureTrend(String[] username, String[] timestamp, String[] temperature) {
        Map<String, Integer> userMap = new HashMap<>();
        for (int i = 0; i < username.length; i++) {
            userMap.put(username[i], i);
        }

        List<int[]> data = new ArrayList<>();
        for (int i = 0; i < username.length; i++) {
            String[] time = timestamp[i].split("-");
            int year = Integer.parseInt(time[0]);
            int month = Integer.parseInt(time[1]);
            int day = Integer.parseInt(time[2]);
            int date = year * 10000 + month * 100 + day;
            data.add(new int[]{date, i});
        }

        data.sort((a, b) -> a[0] - b[0]);

        List<String> result = new ArrayList<>();
        for (int i = 0; i < data.size(); i++) {
            int idx = data.get(i)[1];
            if (i == 0) {
                result.add("No previous");
                continue;
            }
            int prevIdx = data.get(i - 1)[1];
            int currTemp = Integer.parseInt(temperature[idx]);
            int prevTemp = Integer.parseInt(temperature[prevIdx]);
            if (currTemp > prevTemp) {
                result.add("Increase");
            } else if (currTemp < prevTemp) {
                result.add("Decrease");
            } else {
                result.add("No change");
            }
        }

        return result;
    }
}
}