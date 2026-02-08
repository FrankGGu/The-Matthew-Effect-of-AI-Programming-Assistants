class Solution {
    public String digitSum(String s, int k) {
        while (s.length() > k) {
            StringBuilder nextS = new StringBuilder();
            for (int i = 0; i < s.length(); i += k) {
                int currentGroupSum = 0;
                int endIndex = Math.min(i + k, s.length());

                for (int j = i; j < endIndex; j++) {
                    currentGroupSum += (s.charAt(j) - '0');
                }
                nextS.append(currentGroupSum);
            }
            s = nextS.toString();
        }
        return s;
    }
}