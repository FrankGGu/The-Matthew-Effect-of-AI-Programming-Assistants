public class Solution {

import java.util.*;

public class Solution {
    private int n;
    private int m;
    private Set<Integer> used;
    private Random rand;

    public Solution(int n, int m) {
        this.n = n;
        this.m = m;
        this.used = new HashSet<>();
        this.rand = new Random();
    }

    public int[] flip() {
        int index;
        do {
            index = rand.nextInt(n * m);
        } while (used.contains(index));
        used.add(index);
        return new int[]{index / m, index % m};
    }

    public void reset() {
        used.clear();
    }
}
}