class Solution {
    public int getLucky(String s, int k) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            sb.append(c - 'a' + 1);
        }
        String currentNumStr = sb.toString();

        for (int i = 0; i < k; i++) {
            long sum = 0;
            for (char digitChar : currentNumStr.toCharArray()) {
                sum += (digitChar - '0');
            }
            currentNumStr = String.valueOf(sum);
        }

        return Integer.parseInt(currentNumStr);
    }
}