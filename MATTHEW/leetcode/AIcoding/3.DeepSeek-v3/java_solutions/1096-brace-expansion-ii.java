class Solution {
    public List<String> braceExpansionII(String expression) {
        List<String> res = new ArrayList<>();
        Stack<List<String>> stack = new Stack<>();
        Stack<Integer> opStack = new Stack<>();
        List<String> current = new ArrayList<>();
        current.add("");

        for (int i = 0; i < expression.length(); i++) {
            char c = expression.charAt(i);
            if (c == '{') {
                stack.push(new ArrayList<>(current));
                opStack.push(0);
                current = new ArrayList<>();
                current.add("");
            } else if (c == '}') {
                while (opStack.peek() == 1) {
                    current = merge(stack.pop(), current);
                    opStack.pop();
                }
                current = crossProduct(stack.pop(), current);
                opStack.pop();
            } else if (c == ',') {
                stack.push(new ArrayList<>(current));
                opStack.push(1);
                current = new ArrayList<>();
                current.add("");
            } else {
                List<String> temp = new ArrayList<>();
                for (String s : current) {
                    temp.add(s + c);
                }
                current = temp;
            }
        }

        while (!stack.isEmpty()) {
            if (opStack.pop() == 1) {
                current.addAll(stack.pop());
            } else {
                current = crossProduct(stack.pop(), current);
            }
        }

        TreeSet<String> set = new TreeSet<>(current);
        res.addAll(set);
        return res;
    }

    private List<String> crossProduct(List<String> list1, List<String> list2) {
        List<String> res = new ArrayList<>();
        for (String s1 : list1) {
            for (String s2 : list2) {
                res.add(s1 + s2);
            }
        }
        return res;
    }

    private List<String> merge(List<String> list1, List<String> list2) {
        List<String> res = new ArrayList<>(list1);
        res.addAll(list2);
        return res;
    }
}