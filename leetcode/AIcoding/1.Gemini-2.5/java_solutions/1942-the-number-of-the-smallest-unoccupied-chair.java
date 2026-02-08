import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.TreeSet;

class Solution {

    static class Event {
        int time;
        int type; // 0 for departure, 1 for arrival
        int personId;

        Event(int time, int type, int personId) {
            this.time = time;
            this.type = type;
            this.personId = personId;
        }
    }

    public int smallestUnoccupiedChair(int[][] times, int targetPerson) {
        int n = times.length;
        List<Event> events = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            events.add(new Event(times[i][0], 1, i)); // Arrival
            events.add(new Event(times[i][1], 0, i)); // Departure
        }

        Collections.sort(events, (a, b) -> {
            if (a.time != b.time) {
                return a.time - b.time;
            }
            return a.type - b.type; // Departure (0) before Arrival (1)
        });

        TreeSet<Integer> availableChairs = new TreeSet<>();
        for (int i = 0; i < n; i++) {
            availableChairs.add(i);
        }

        int[] personChairMap = new int[n];

        for (Event event : events) {
            if (event.type == 0) { // Departure
                availableChairs.add(personChairMap[event.personId]);
            } else { // Arrival
                int chairId = availableChairs.pollFirst();
                personChairMap[event.personId] = chairId;
                if (event.personId == targetPerson) {
                    return chairId;
                }
            }
        }
        return -1; 
    }
}