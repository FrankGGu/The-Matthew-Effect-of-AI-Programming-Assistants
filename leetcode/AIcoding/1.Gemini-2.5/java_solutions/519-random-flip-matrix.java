import java.util.HashMap;
import java.util.Random;

class Solution {

    private int mRows;
    private int nCols;
    private int totalSize;
    private Random rand;
    private HashMap<Integer, Integer> map;

    public Solution(int m, int n) {
        mRows = m;
        nCols = n;
        totalSize = m * n;
        rand = new Random();
        map = new HashMap<>();
    }

    public int[] flip() {
        int idxToFlip = rand.nextInt(totalSize);

        int actual1DIdx = map.getOrDefault(idxToFlip, idxToFlip);

        int lastVal = map.getOrDefault(totalSize - 1, totalSize - 1);

        map.put(idxToFlip, lastVal);
        map.remove(totalSize - 1);

        totalSize--;

        return new int[]{actual1DIdx / nCols, actual1DIdx % nCols};
    }

    public void reset() {
        totalSize = mRows * nCols;
        map.clear();
    }
}