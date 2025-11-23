public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public static List<List<String>> displayFirstThreeRows(List<List<String>> data) {
        List<List<String>> result = new ArrayList<>();
        for (int i = 0; i < Math.min(3, data.size()); i++) {
            result.add(data.get(i));
        }
        return result;
    }
}
}