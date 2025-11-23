public class Solution {

import java.util.*;

public class Solution {
    public int colorTheArray(int n, int[] queries) {
        int[] color = new int[n];
        int result = 0;
        for (int[] query : queries) {
            int index = query[0];
            int newColor = query[1];
            if (color[index] == newColor) continue;
            color[index] = newColor;
            int count = 0;
            if (index > 0 && color[index] == color[index - 1]) count++;
            if (index < n - 1 && color[index] == color[index + 1]) count++;
            result += count;
        }
        return result;
    }
}
}