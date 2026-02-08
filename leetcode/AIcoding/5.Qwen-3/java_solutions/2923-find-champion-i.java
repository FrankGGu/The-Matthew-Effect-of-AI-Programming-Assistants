public class Solution {

import java.util.*;

public class Solution {
    public int findChampion(int n, int[][] edges) {
        int[] inDegree = new int[n];
        for (int[] edge : edges) {
            inDegree[edge[1]]++;
        }

        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                return i;
            }
        }

        return -1;
    }
}
}