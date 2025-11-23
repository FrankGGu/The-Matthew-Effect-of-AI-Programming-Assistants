public class Solution {

import java.util.*;

public class Solution {
    public int minStalls(int[] people, int k) {
        Arrays.sort(people);
        int stalls = 0;
        int i = 0;
        while (i < people.length) {
            int start = people[i];
            stalls++;
            i++;
            while (i < people.length && people[i] - start <= k) {
                i++;
            }
        }
        return stalls;
    }
}
}