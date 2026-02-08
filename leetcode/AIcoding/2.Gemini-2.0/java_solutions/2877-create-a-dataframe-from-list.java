import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.RowFactory;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

class Solution {

    public Dataset<Row> createDataFrame(List<List<Object>> data, List<String> columns) {
        SparkSession spark = SparkSession.builder().master("local[*]").appName("CreateDataFrame").getOrCreate();

        List<Row> rows = new ArrayList<>();
        for (List<Object> rowData : data) {
            rows.add(RowFactory.create(rowData.toArray()));
        }

        List<StructField> fields = new ArrayList<>();
        for (String columnName : columns) {
            fields.add(DataTypes.createStructField(columnName, DataTypes.StringType, true));
        }
        StructType schema = DataTypes.createStructType(fields);

        Dataset<Row> df = spark.createDataFrame(rows, schema);
        return df;
    }
}