public class Solution {
    public int maxDiff(int num) {
        String s = String.valueOf(num);
        int n = s.length();
        int minNum = num;
        int maxNum = num;

        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (c != '9') {
                StringBuilder sb = new StringBuilder(s);
                for (int j = i; j < n; j++) {
                    if (sb.charAt(j) == c) {
                        sb.setCharAt(j, '9');
                    }
                }
                maxNum = Math.max(maxNum, Integer.parseInt(sb.toString()));
                break;
            }
        }

        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (c != '1' && i != 0) {
                StringBuilder sb = new StringBuilder(s);
                for (int j = i; j < n; j++) {
                    if (sb.charAt(j) == c) {
                        sb.setCharAt(j, '1');
                    }
                }
                minNum = Math.min(minNum, Integer.parseInt(sb.toString()));
                break;
            }
        }

        return maxNum - minNum;
    }
}