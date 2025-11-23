class Solution {
    public int maxDiff(int num) {
        String s = Integer.toString(num);
        int max = Integer.MIN_VALUE;
        int min = Integer.MAX_VALUE;

        for (int i = 0; i <= 9; i++) {
            for (int j = 0; j <= 9; j++) {
                String replaced = s.replaceAll(String.valueOf(i), String.valueOf(j));
                if (replaced.charAt(0) == '0') continue;
                int val = Integer.parseInt(replaced);
                if (val > max) max = val;
                if (val < min) min = val;
            }
        }

        return max - min;
    }
}