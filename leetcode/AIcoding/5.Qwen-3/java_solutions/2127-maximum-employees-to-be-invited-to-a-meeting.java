public class Solution {

import java.util.*;

public class Solution {
    public int maxEmployeesToInvite(int[] arr) {
        boolean[] visited = new boolean[arr.length];
        int result = 0;
        for (int i = 0; i < arr.length; i++) {
            if (!visited[i]) {
                Map<Integer, Integer> map = new HashMap<>();
                int current = i;
                int count = 0;
                while (!visited[current]) {
                    visited[current] = true;
                    if (map.containsKey(arr[current])) {
                        if (map.get(arr[current]) == current) {
                            result += count - map.get(arr[current]) + 1;
                        }
                        break;
                    }
                    map.put(current, arr[current]);
                    current = arr[current];
                    count++;
                }
            }
        }
        return result;
    }
}
}