import java.util.Random;
import java.util.HashMap;
import java.util.Map;

class Solution {
    private int rows;
    private int cols;
    private int total;
    private Random rand;
    private Map<Integer, Integer> map;

    public Solution(int n_rows, int n_cols) {
        this.rows = n_rows;
        this.cols = n_cols;
        this.total = rows * cols;
        this.rand = new Random();
        this.map = new HashMap<>();
    }

    public int[] flip() {
        int r = rand.nextInt(total--);
        int x = map.getOrDefault(r, r);
        map.put(r, map.getOrDefault(total, total));
        return new int[]{x / cols, x % cols};
    }

    public void reset() {
        total = rows * cols;
        map.clear();
    }
}