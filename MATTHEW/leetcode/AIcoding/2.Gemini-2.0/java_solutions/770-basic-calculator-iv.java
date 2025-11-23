import java.util.*;

class Solution {
    public List<String> basicCalculatorIV(String expression, String[] evalvars, int[] evalints) {
        Map<String, Integer> evalMap = new HashMap<>();
        for (int i = 0; i < evalvars.length; i++) {
            evalMap.put(evalvars[i], evalints[i]);
        }

        List<String> tokens = tokenize(expression);
        Deque<List<Integer>> nums = new LinkedList<>();
        Deque<Character> ops = new LinkedList<>();

        nums.push(evaluate(Arrays.asList("1")));

        for (String token : tokens) {
            if (token.equals("(")) {
                ops.push('(');
            } else if (token.equals(")")) {
                while (ops.peek() != '(') {
                    compute(nums, ops);
                }
                ops.pop();
            } else if (token.equals("+") || token.equals("-") || token.equals("*")) {
                int priority = token.equals("*") ? 2 : 1;
                while (!ops.isEmpty() && ops.peek() != '(') {
                    char op = ops.peek();
                    int opPriority = op == '*' ? 2 : 1;
                    if (opPriority >= priority) {
                        compute(nums, ops);
                    } else {
                        break;
                    }
                }
                ops.push(token.charAt(0));
            } else {
                if (Character.isLetter(token.charAt(0)) && evalMap.containsKey(token)) {
                    nums.push(evaluate(Arrays.asList(String.valueOf(evalMap.get(token)))));
                } else {
                    nums.push(evaluate(Arrays.asList(token)));
                }
            }
        }

        while (!ops.isEmpty()) {
            compute(nums, ops);
        }

        List<Integer> result = nums.pop();
        Collections.sort(result, (a, b) -> {
            int aSize = a / 1000000;
            int bSize = b / 1000000;
            if (aSize != bSize) {
                return bSize - aSize;
            }
            String aStr = getVar(a);
            String bStr = getVar(b);
            return aStr.compareTo(bStr);
        });

        List<String> ans = new ArrayList<>();
        for (int item : result) {
            if (item % 1000000 != 0) {
                ans.add(getVar(item) + (getVar(item).isEmpty() ? "" : "*") + (item % 1000000 == 1 ? "" : item % 1000000));
            }
        }

        return ans;
    }

    private List<String> tokenize(String expression) {
        List<String> tokens = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        for (char c : expression.toCharArray()) {
            if (c == ' ') {
                if (sb.length() > 0) {
                    tokens.add(sb.toString());
                    sb.setLength(0);
                }
            } else if (c == '(' || c == ')' || c == '+' || c == '-' || c == '*') {
                if (sb.length() > 0) {
                    tokens.add(sb.toString());
                    sb.setLength(0);
                }
                tokens.add(String.valueOf(c));
            } else {
                sb.append(c);
            }
        }
        if (sb.length() > 0) {
            tokens.add(sb.toString());
        }
        return tokens;
    }

    private List<Integer> evaluate(List<String> tokens) {
        List<Integer> result = new ArrayList<>();
        if (tokens.size() == 1) {
            try {
                int num = Integer.parseInt(tokens.get(0));
                result.add(num);
            } catch (NumberFormatException e) {
                result.add(1000000 + varToInt(tokens.get(0)));
            }
        } else {
            int size = tokens.size();
            int mask = size * 1000000;
            StringBuilder sb = new StringBuilder();
            for(String token : tokens) {
                sb.append(token);
            }
            result.add(mask + varToInt(sb.toString()));
        }
        return result;
    }

    private void compute(Deque<List<Integer>> nums, Deque<Character> ops) {
        List<Integer> num2 = nums.pop();
        List<Integer> num1 = nums.pop();
        char op = ops.pop();
        List<Integer> result = new ArrayList<>();

        for (int n1 : num1) {
            for (int n2 : num2) {
                int coeff1 = n1 % 1000000;
                int coeff2 = n2 % 1000000;
                String var1 = getVar(n1);
                String var2 = getVar(n2);
                int newCoeff = 0;
                String newVar = "";

                if (op == '+') {
                    newCoeff = coeff1 + coeff2;
                    newVar = var1 + var2;
                } else if (op == '-') {
                    newCoeff = coeff1 - coeff2;
                    newVar = var1 + var2;
                } else {
                    if (var1.isEmpty() || var2.isEmpty()) continue;
                    newCoeff = coeff1 * coeff2;
                    newVar = var1 + var2;
                }

                int varInt = varToInt(newVar);
                int newNum = (newVar.length() / 2) * 1000000 + varInt;

                boolean found = false;
                for (int i = 0; i < result.size(); i++) {
                    if (result.get(i) / 1000000 == newNum / 1000000 && result.get(i) % 1000000 == newNum % 1000000) {
                        result.set(i, result.get(i) + newCoeff);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    result.add(newNum + newCoeff);
                }
            }
        }
        nums.push(result);
    }

    private int varToInt(String var) {
        if (var.isEmpty()) return 0;
        int res = 0;
        for (char c : var.toCharArray()) {
            res = res * 53 + (c - 'a' + 1);
        }
        return res;
    }

    private String getVar(int num) {
        int varInt = num % 1000000;
        if (varInt == 0) return "";

        StringBuilder sb = new StringBuilder();
        while (varInt > 0) {
            sb.append((char) ((varInt % 53) + 'a' - 1));
            varInt /= 53;
        }
        return sb.reverse().toString();
    }
}