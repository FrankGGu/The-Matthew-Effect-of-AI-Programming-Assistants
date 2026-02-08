public class Solution {

import java.util.*;

public class Solution {
    public List<String> addOperators(String num, int target) {
        List<String> result = new ArrayList<>();
        dfs(num, target, 0, "", 0, 0, result);
        return result;
    }

    private void dfs(String num, int target, int index, String path, long prev, long curr, List<String> result) {
        if (index == num.length()) {
            if (curr == target) {
                result.add(path);
            }
            return;
        }

        for (int i = index; i < num.length(); i++) {
            if (num.charAt(index) == '0' && i != index) {
                break;
            }

            long current = Long.parseLong(num.substring(index, i + 1));

            if (index == 0) {
                dfs(num, target, i + 1, String.valueOf(current), current, current, result);
            } else {
                dfs(num, target, i + 1, path + "+" + current, current, curr + current, result);
                dfs(num, target, i + 1, path + "-" + current, -current, curr - current, result);
                dfs(num, target, i + 1, path + "*" + current, prev * current, curr - prev + prev * current, result);
            }
        }
    }
}
}