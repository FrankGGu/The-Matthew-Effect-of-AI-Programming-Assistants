class Solution {
    public boolean sumGame(String num) {
        int n = num.length();
        int leftSum = 0, rightSum = 0, leftUnknowns = 0, rightUnknowns = 0;

        for (int i = 0; i < n / 2; i++) {
            char c = num.charAt(i);
            if (c == '?') {
                leftUnknowns++;
            } else {
                leftSum += c - '0';
            }
        }

        for (int i = n / 2; i < n; i++) {
            char c = num.charAt(i);
            if (c == '?') {
                rightUnknowns++;
            } else {
                rightSum += c - '0';
            }
        }

        int leftMax = leftSum + 9 * leftUnknowns;
        int leftMin = leftSum;
        int rightMax = rightSum + 9 * rightUnknowns;
        int rightMin = rightSum;

        return !(leftMax < rightMin || leftMin > rightMax);
    }
}