import java.util.Random;

public class RandomFlipMatrix {
    private int rows;
    private int cols;
    private int total;
    private Random random;
    private int[] map;

    public RandomFlipMatrix(int n_rows, int n_cols) {
        this.rows = n_rows;
        this.cols = n_cols;
        this.total = n_rows * n_cols;
        this.random = new Random();
        this.map = new int[total];
        for (int i = 0; i < total; i++) {
            map[i] = i;
        }
    }

    public int[] flip() {
        int index = random.nextInt(total);
        int val = map[index];
        map[index] = map[total - 1];
        map[total - 1] = val;
        total--;
        return new int[]{val / cols, val % cols};
    }

    public void reset() {
        total = rows * cols;
        for (int i = 0; i < total; i++) {
            map[i] = i;
        }
    }
}