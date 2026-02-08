import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int[][] reconstructQueue(int[][] people) {
        Arrays.sort(people, new Comparator<int[]>(){
            public int compare(int[] a, int[] b) {
                if (a[0] == b[0]) {
                    return a[1] - b[1];
                }
                return b[0] - a[0];
            }
        });

        int[][] result = new int[people.length][2];
        for (int i = 0; i < people.length; i++) {
            result[i][0] = -1;
        }

        for (int[] person : people) {
            int count = person[1];
            for (int j = 0; j < result.length; j++) {
                if (result[j][0] == -1) {
                    if (count == 0) {
                        result[j] = person;
                        break;
                    }
                    count--;
                }
            }
        }

        return result;
    }
}