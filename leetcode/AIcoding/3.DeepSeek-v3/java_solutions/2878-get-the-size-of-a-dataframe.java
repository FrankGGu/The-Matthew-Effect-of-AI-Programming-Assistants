import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;

class Solution {
    public int[] getDataFrameSize(Dataset<Row> df) {
        long numRows = df.count();
        int numCols = df.columns().length;
        return new int[]{(int) numRows, numCols};
    }
}