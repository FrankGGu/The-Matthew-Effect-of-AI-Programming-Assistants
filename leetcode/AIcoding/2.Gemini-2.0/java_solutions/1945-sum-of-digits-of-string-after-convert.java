class Solution {
    public int getLucky(String s, int k) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            int val = c - 'a' + 1;
            sb.append(val);
        }
        String num = sb.toString();
        int sum = 0;
        for (int i = 0; i < k; i++) {
            sum = 0;
            for (char c : num.toCharArray()) {
                sum += c - '0';
            }
            num = String.valueOf(sum);
        }
        return sum;
    }
}