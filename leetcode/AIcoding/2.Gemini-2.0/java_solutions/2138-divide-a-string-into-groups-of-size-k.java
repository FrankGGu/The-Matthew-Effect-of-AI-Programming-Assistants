class Solution {
    public String[] divideString(String s, int k, char fill) {
        int n = s.length();
        int numGroups = (n + k - 1) / k;
        String[] result = new String[numGroups];

        for (int i = 0; i < numGroups; i++) {
            StringBuilder sb = new StringBuilder();
            for (int j = i * k; j < Math.min((i + 1) * k, n); j++) {
                sb.append(s.charAt(j));
            }
            while (sb.length() < k) {
                sb.append(fill);
            }
            result[i] = sb.toString();
        }

        return result;
    }
}