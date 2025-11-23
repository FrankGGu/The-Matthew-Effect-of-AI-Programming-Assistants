public class Solution {
    public int garbageCollection(String[] garbage, int[][] travel) {
        int n = garbage.length;
        int[] time = new int[3]; // 0: paper, 1: glass, 2: metal
        int[] last = new int[3]; // last index where each type appears

        for (int i = 0; i < n; i++) {
            String s = garbage[i];
            for (int j = 0; j < s.length(); j++) {
                char c = s.charAt(j);
                if (c == 'P') {
                    time[0]++;
                    last[0] = i;
                } else if (c == 'G') {
                    time[1]++;
                    last[1] = i;
                } else if (c == 'M') {
                    time[2]++;
                    last[2] = i;
                }
            }
        }

        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < last[i]; j++) {
                time[i] += travel[j][i];
            }
        }

        return time[0] + time[1] + time[2];
    }
}