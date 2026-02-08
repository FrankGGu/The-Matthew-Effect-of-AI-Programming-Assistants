class Solution {
    public int numSteps(String s) {
        int steps = 0;
        StringBuilder sb = new StringBuilder(s);

        while (!sb.toString().equals("1")) {
            if (sb.charAt(sb.length() - 1) == '0') {
                sb.deleteCharAt(sb.length() - 1);
            } else {
                sb = new StringBuilder(incrementBinary(sb.toString()));
            }
            steps++;
        }
        return steps;
    }

    private String incrementBinary(String s) {
        StringBuilder sb = new StringBuilder();
        int carry = 1;

        for (int i = s.length() - 1; i >= 0; i--) {
            if (s.charAt(i) == '1' && carry == 1) {
                sb.append('0');
            } else if (s.charAt(i) == '0' && carry == 1) {
                sb.append('1');
                carry = 0;
            } else {
                sb.append(s.charAt(i));
            }
        }

        if (carry == 1) {
            sb.append('1');
        }

        return sb.reverse().toString();
    }
}