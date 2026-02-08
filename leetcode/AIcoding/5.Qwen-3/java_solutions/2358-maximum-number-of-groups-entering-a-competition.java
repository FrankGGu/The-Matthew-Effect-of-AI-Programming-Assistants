public class Solution {

import java.util.*;

public class Solution {
    public int maximumGroups(int[] grades) {
        Arrays.sort(grades);
        int count = 1;
        int prev = grades[0];
        for (int i = 1; i < grades.length; i++) {
            if (grades[i] != prev) {
                count++;
                prev = grades[i];
            }
        }
        return count;
    }
}
}