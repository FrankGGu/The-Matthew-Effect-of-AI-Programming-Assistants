class Solution {
    public int finalValueAfterOperations(String[] operations) {
        int x = 0;
        for (String op : operations) {
            if (op.equals("++X") || op.equals("X++")) {
                if (op.charAt(1) == '+') {
                    if (op.charAt(0) == '+') {
                        ++x;
                    } else {
                        x++;
                    }
                }
            } else {
                if (op.charAt(1) == '-') {
                    if (op.charAt(0) == '-') {
                        --x;
                    } else {
                        x--;
                    }
                }
            }
        }
        return x;
    }
}