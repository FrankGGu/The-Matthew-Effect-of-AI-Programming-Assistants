import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public DataFrame renameColumns(DataFrame df, List<String> names) {
        if (df == null || df.columns.size() != names.size()) {
            return df;
        }

        df.columns = names;
        return df;
    }
}