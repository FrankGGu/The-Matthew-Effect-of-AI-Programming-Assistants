public class Solution {

import java.util.*;

public class Solution {
    public int smallestDivisibleByK(int n) {
        Set<Integer> seen = new HashSet<>();
        int current = 0;
        int length = 0;

        while (true) {
            current = (current * 10 + 1) % n;
            length++;
            if (current == 0) {
                return length;
            }
            if (seen.contains(current)) {
                return -1;
            }
            seen.add(current);
        }
    }
}
}