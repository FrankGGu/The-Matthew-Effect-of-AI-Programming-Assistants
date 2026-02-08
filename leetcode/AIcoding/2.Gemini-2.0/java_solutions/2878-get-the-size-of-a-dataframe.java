import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;

class Solution {

    public int getSize(Dataset<Row> dataframe) {
        return (int) dataframe.count();
    }
}