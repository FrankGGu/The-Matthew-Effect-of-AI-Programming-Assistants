import java.util.*;

class Solution {
    public String countOfAtoms(String formula) {
        Map<String, Integer> atomCount = new HashMap<>();
        Deque<Map<String, Integer>> stack = new ArrayDeque<>();
        int i = 0;

        while (i < formula.length()) {
            char c = formula.charAt(i);
            if (Character.isUpperCase(c)) {
                StringBuilder atom = new StringBuilder().append(c);
                i++;
                while (i < formula.length() && Character.isLowerCase(formula.charAt(i))) {
                    atom.append(formula.charAt(i++));
                }
                String atomStr = atom.toString();
                int count = 1;
                while (i < formula.length() && Character.isDigit(formula.charAt(i))) {
                    count = count * 10 + (formula.charAt(i++) - '0');
                }
                atomCount.put(atomStr, atomCount.getOrDefault(atomStr, 0) + count);
            } else if (c == '(') {
                stack.push(atomCount);
                atomCount = new HashMap<>();
                i++;
            } else if (c == ')') {
                i++;
                int count = 1;
                while (i < formula.length() && Character.isDigit(formula.charAt(i))) {
                    count = count * 10 + (formula.charAt(i++) - '0');
                }
                for (String key : atomCount.keySet()) {
                    atomCount.put(key, atomCount.get(key) * count);
                }
                Map<String, Integer> prevCount = stack.pop();
                for (String key : atomCount.keySet()) {
                    prevCount.put(key, prevCount.getOrDefault(key, 0) + atomCount.get(key));
                }
                atomCount = prevCount;
            }
        }

        List<String> keys = new ArrayList<>(atomCount.keySet());
        Collections.sort(keys);
        StringBuilder result = new StringBuilder();
        for (String key : keys) {
            result.append(key);
            int count = atomCount.get(key);
            if (count > 1) {
                result.append(count);
            }
        }
        return result.toString();
    }
}