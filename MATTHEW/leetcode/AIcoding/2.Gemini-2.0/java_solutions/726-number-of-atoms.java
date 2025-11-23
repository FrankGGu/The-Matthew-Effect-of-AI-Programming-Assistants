import java.util.Map;
import java.util.TreeMap;
import java.util.Stack;

class Solution {
    public String countOfAtoms(String formula) {
        int n = formula.length();
        Stack<Map<String, Integer>> stack = new Stack<>();
        Map<String, Integer> map = new TreeMap<>();
        int i = 0;
        while (i < n) {
            char c = formula.charAt(i++);
            if (c == '(') {
                stack.push(map);
                map = new TreeMap<>();
            } else if (c == ')') {
                int num = 0;
                while (i < n && Character.isDigit(formula.charAt(i))) {
                    num = num * 10 + (formula.charAt(i++) - '0');
                }
                if (num == 0) num = 1;
                Map<String, Integer> temp = stack.pop();
                for (String key : map.keySet()) {
                    temp.put(key, temp.getOrDefault(key, 0) + map.get(key) * num);
                }
                map = temp;
            } else {
                int start = i - 1;
                while (i < n && Character.isLowerCase(formula.charAt(i))) {
                    i++;
                }
                String atom = formula.substring(start, i);
                int num = 0;
                while (i < n && Character.isDigit(formula.charAt(i))) {
                    num = num * 10 + (formula.charAt(i++) - '0');
                }
                if (num == 0) num = 1;
                map.put(atom, map.getOrDefault(atom, 0) + num);
            }
        }
        StringBuilder sb = new StringBuilder();
        for (String key : map.keySet()) {
            sb.append(key);
            int count = map.get(key);
            if (count > 1) {
                sb.append(count);
            }
        }
        return sb.toString();
    }
}