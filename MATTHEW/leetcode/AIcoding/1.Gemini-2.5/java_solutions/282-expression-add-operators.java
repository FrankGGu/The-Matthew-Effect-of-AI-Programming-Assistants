import java.util.ArrayList;
import java.util.List;

class Solution {
    List<String> result;
    String num;
    int target;

    public List<String> addOperators(String num, int target) {
        this.result = new ArrayList<>();
        this.num = num;
        this.target = target;
        if (num == null || num.length() == 0) {
            return result;
        }
        dfs(0, 0, 0, new StringBuilder());
        return result;
    }

    private void dfs(int index, long currentEval, long lastNum, StringBuilder path) {
        if (index == num.length()) {
            if (currentEval == target) {
                result.add(path.toString());
            }
            return;
        }

        for (int i = index; i < num.length(); i++) {
            if (i > index && num.charAt(index) == '0') {
                break; 
            }

            String currentNumStr = num.substring(index, i + 1);
            long currentNumVal = Long.parseLong(currentNumStr);

            int pathLen = path.length();

            if (index == 0) {
                path.append(currentNumStr);
                dfs(i + 1, currentNumVal, currentNumVal, path);
                path.setLength(pathLen);
            } else {
                path.append("+").append(currentNumStr);
                dfs(i + 1, currentEval + currentNumVal, currentNumVal, path);
                path.setLength(pathLen);

                path.append("-").append(currentNumStr);
                dfs(i + 1, currentEval - currentNumVal, -currentNumVal, path);
                path.setLength(pathLen);

                path.append("*").append(currentNumStr);
                dfs(i + 1, currentEval - lastNum + (lastNum * currentNumVal), lastNum * currentNumVal, path);
                path.setLength(pathLen);
            }
        }
    }
}