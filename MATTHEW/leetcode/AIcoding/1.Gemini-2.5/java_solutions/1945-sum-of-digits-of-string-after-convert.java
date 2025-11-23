class Solution {
    public int getLucky(String s, int k) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            sb.append(c - 'a' + 1);
        }

        String currentNumStr = sb.toString();
        int currentSum = 0;

        for (int i = 0; i < k; i++) {
            currentSum = 0;
            for (char digitChar : currentNumStr.toCharArray()) {
                currentSum += (digitChar - '0');
            }
            if (i < k - 1) {
                currentNumStr = String.valueOf(currentSum);
            }
        }

        return currentSum;
    }
}