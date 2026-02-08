public class Solution {

import java.util.*;

public class Solution {
    private TreeSet<Integer> sortedIntervals;

    public Solution() {
        sortedIntervals = new TreeSet<>();
    }

    public void add(int value) {
        sortedIntervals.add(value);
    }

    public int count() {
        return sortedIntervals.size();
    }
}
}