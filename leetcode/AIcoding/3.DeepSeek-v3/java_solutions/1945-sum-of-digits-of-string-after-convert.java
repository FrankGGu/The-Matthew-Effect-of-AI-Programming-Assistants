class Solution {
    public int getLucky(String s, int k) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            sb.append(c - 'a' + 1);
        }
        String numStr = sb.toString();
        int sum = 0;
        for (int i = 0; i < k; i++) {
            sum = 0;
            for (char c : numStr.toCharArray()) {
                sum += c - '0';
            }
            numStr = String.valueOf(sum);
        }
        return sum;
    }
}