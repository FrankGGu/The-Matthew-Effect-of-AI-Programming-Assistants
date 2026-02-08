class Solution {
    public String decodeString(String s) {
        StringBuilder res = new StringBuilder();
        int num = 0;
        Deque<Integer> countStack = new ArrayDeque<>();
        Deque<String> stringStack = new ArrayDeque<>();

        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                num = num * 10 + (c - '0');
            } else if (c == '[') {
                countStack.push(num);
                stringStack.push(res.toString());
                num = 0;
                res = new StringBuilder();
            } else if (c == ']') {
                StringBuilder temp = new StringBuilder(stringStack.pop());
                int count = countStack.pop();
                for (int i = 0; i < count; i++) {
                    temp.append(res);
                }
                res = temp;
            } else {
                res.append(c);
            }
        }

        return res.toString();
    }
}