class Solution {
    public String orderlyQueue(String s, int k) {
        if (k == 1) {
            String minString = s;
            for (int i = 0; i < s.length(); i++) {
                String rotated = s.substring(i) + s.substring(0, i);
                if (rotated.compareTo(minString) < 0) {
                    minString = rotated;
                }
            }
            return minString;
        } else {
            char[] chars = s.toCharArray();
            Arrays.sort(chars);
            return new String(chars);
        }
    }
}