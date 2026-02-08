class Solution {
    public String[] divideString(String s, int k, char fill) {
        int n = s.length();
        int groups = (n + k - 1) / k;
        String[] result = new String[groups];
        for (int i = 0; i < groups; i++) {
            int start = i * k;
            int end = Math.min(start + k, n);
            String group = s.substring(start, end);
            if (group.length() < k) {
                group += String.valueOf(fill).repeat(k - group.length());
            }
            result[i] = group;
        }
        return result;
    }
}