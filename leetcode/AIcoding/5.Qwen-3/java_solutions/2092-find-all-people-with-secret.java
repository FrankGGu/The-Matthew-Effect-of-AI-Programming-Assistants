public class Solution {

import java.util.*;

public class Solution {
    public int[] findAllPeople(int n, int[][] meetings, int firstPerson) {
        Arrays.sort(meetings, (a, b) -> a[2] - b[2]);
        Map<Integer, List<int[]>> graph = new HashMap<>();

        for (int[] meeting : meetings) {
            graph.putIfAbsent(meeting[0], new ArrayList<>());
            graph.putIfAbsent(meeting[1], new ArrayList<>());
            graph.get(meeting[0]).add(new int[]{meeting[1], meeting[2]});
            graph.get(meeting[1]).add(new int[]{meeting[0], meeting[2]});
        }

        boolean[] knowSecret = new boolean[n];
        knowSecret[firstPerson] = true;

        int[] result = new int[n];
        int count = 0;

        for (int i = 0; i < n; i++) {
            if (knowSecret[i]) {
                result[count++] = i;
            }
        }

        return Arrays.copyOf(result, count);
    }
}
}