class Solution {
    public String[] divideString(String s, int k, char fill) {
        int n = s.length();
        int groups = (n + k - 1) / k;
        String[] result = new String[groups];

        for (int i = 0; i < groups; i++) {
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j < k; j++) {
                if (i * k + j < n) {
                    sb.append(s.charAt(i * k + j));
                } else {
                    sb.append(fill);
                }
            }
            result[i] = sb.toString();
        }
        return result;
    }
}