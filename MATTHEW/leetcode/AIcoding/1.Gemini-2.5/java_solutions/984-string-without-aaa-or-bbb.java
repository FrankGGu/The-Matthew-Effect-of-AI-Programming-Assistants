class Solution {
    public String strWithout3a3b(int a, int b) {
        StringBuilder sb = new StringBuilder();

        while (a > 0 || b > 0) {
            boolean canAppendA = (a > 0) && !(sb.length() >= 2 && sb.charAt(sb.length() - 1) == 'a' && sb.charAt(sb.length() - 2) == 'a');
            boolean canAppendB = (b > 0) && !(sb.length() >= 2 && sb.charAt(sb.length() - 1) == 'b' && sb.charAt(sb.length() - 2) == 'b');

            if (canAppendA && canAppendB) {
                // Both 'a' and 'b' can be appended without creating 'aaa' or 'bbb'.
                // Choose the character that has more remaining count to keep the string balanced.
                if (a >= b) {
                    sb.append('a');
                    a--;
                } else {
                    sb.append('b');
                    b--;
                }
            } else if (canAppendA) {
                // Only 'a' can be appended.
                sb.append('a');
                a--;
            } else if (canAppendB) {
                // Only 'b' can be appended.
                sb.append('b');
                b--;
            } else {
                // This case should ideally not be reached if a solution always exists for the given a, b.
                // It means both 'a' and 'b' are blocked (either count is 0, or appending would create 'aaa'/'bbb').
                // If a solution exists, at least one should be appendable.
                break; 
            }
        }
        return sb.toString();
    }
}