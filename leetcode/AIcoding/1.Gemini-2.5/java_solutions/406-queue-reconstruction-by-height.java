import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

class Solution {
    public int[][] reconstructQueue(int[][] people) {
        Arrays.sort(people, new Comparator<int[]>() {
            @Override
            public int compare(int[] p1, int[] p2) {
                if (p1[0] != p2[0]) {
                    return p2[0] - p1[0]; // Sort by height descending
                } else {
                    return p1[1] - p2[1]; // If heights are equal, sort by k ascending
                }
            }
        });

        List<int[]> reconstructedQueue = new ArrayList<>();
        for (int[] person : people) {
            reconstructedQueue.add(person[1], person);
        }

        return reconstructedQueue.toArray(new int[reconstructedQueue.size()][]);
    }
}