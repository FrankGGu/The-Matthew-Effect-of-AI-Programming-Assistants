import java.util.List;
import org.apache.commons.lang3.StringUtils;

class Solution {
    public List<String> modifyColumns(List<String> columns) {
        for (int i = 0; i < columns.size(); i++) {
            String column = columns.get(i);
            if (StringUtils.isNumeric(column)) {
                columns.set(i, "num_" + column);
            } else {
                columns.set(i, "str_" + column);
            }
        }
        return columns;
    }
}