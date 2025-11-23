import java.util.HashMap;
import java.util.Map;
import java.util.Random;

class Solution {

    private int rows;
    private int cols;
    private int total;
    private Random random;
    private Map<Integer, Integer> map;

    public Solution(int n_rows, int n_cols) {
        rows = n_rows;
        cols = n_cols;
        total = n_rows * n_cols;
        random = new Random();
        map = new HashMap<>();
    }

    public int[] flip() {
        int r = random.nextInt(total);
        int x = map.getOrDefault(r, r);
        map.put(r, map.getOrDefault(total - 1, total - 1));
        total--;
        return new int[]{x / cols, x % cols};
    }

    public void reset() {
        total = rows * cols;
        map.clear();
    }
}