class Solution {
    public String decodeString(String s) {
        StringBuilder res = new StringBuilder();
        int num = 0;
        Stack<Integer> numStack = new Stack<>();
        Stack<StringBuilder> resStack = new Stack<>();
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                num = num * 10 + (c - '0');
            } else if (c == '[') {
                numStack.push(num);
                resStack.push(res);
                res = new StringBuilder();
                num = 0;
            } else if (c == ']') {
                StringBuilder temp = resStack.pop();
                int repeatTimes = numStack.pop();
                for (int i = 0; i < repeatTimes; i++) {
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