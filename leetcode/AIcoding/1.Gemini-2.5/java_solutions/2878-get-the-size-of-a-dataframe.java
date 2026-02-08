import java.util.List;

class Solution {

    public int[] getDataFrameSize(List<List<Integer>> df) {
        int rows = df.size();
        int cols = 0;
        if (rows > 0) {
            cols = df.get(0).size();
        }
        return new int[]{rows, cols};
    }
}