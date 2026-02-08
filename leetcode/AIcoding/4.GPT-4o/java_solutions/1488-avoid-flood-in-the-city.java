import java.util.*;

class Solution {
    public boolean canAvoidFlood(int[] rains) {
        Set<Integer> filledLakes = new HashSet<>();
        TreeSet<Integer> dryDays = new TreeSet<>();

        for (int day = 0; day < rains.length; day++) {
            if (rains[day] == 0) {
                dryDays.add(day);
            } else {
                if (filledLakes.contains(rains[day])) {
                    return false;
                }
                filledLakes.add(rains[day]);
                if (!dryDays.isEmpty()) {
                    Integer dryDay = dryDays.pollFirst();
                    if (dryDay != null && dryDay < day) {
                        dryDays.add(dryDay);
                    }
                }
            }
        }

        return true;
    }
}