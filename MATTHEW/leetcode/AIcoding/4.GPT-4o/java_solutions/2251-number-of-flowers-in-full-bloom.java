import java.util.*;

public class Solution {
    public int[] numOfFlowers(int[][] flowers, int[] persons) {
        int n = flowers.length;
        int m = persons.length;
        int[] result = new int[m];

        List<int[]> events = new ArrayList<>();

        for (int[] flower : flowers) {
            events.add(new int[]{flower[0], 1});
            events.add(new int[]{flower[1] + 1, -1});
        }

        for (int i = 0; i < m; i++) {
            events.add(new int[]{persons[i], 0, i});
        }

        Collections.sort(events, (a, b) -> {
            if (a[0] != b[0]) return Integer.compare(a[0], b[0]);
            return Integer.compare(a[1], b[1]);
        });

        int count = 0;

        for (int[] event : events) {
            if (event[1] == 1) {
                count++;
            } else if (event[1] == -1) {
                count--;
            } else {
                result[event[2]] = count;
            }
        }

        return result;
    }
}