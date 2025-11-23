public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> validStrings(int n) {
        List<String> result = new ArrayList<>();
        generate(n, "", result);
        return result;
    }

    private void generate(int n, String current, List<String> result) {
        if (current.length() == n) {
            result.add(current);
            return;
        }
        if (current.isEmpty() || current.charAt(current.length() - 1) == '0') {
            generate(n, current + "1", result);
        } else {
            generate(n, current + "0", result);
            generate(n, current + "1", result);
        }
    }
}
}