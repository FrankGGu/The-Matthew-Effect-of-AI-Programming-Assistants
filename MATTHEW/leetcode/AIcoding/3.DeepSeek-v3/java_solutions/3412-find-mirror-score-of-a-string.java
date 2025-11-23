class Solution {
    public int mirrorScore(String s) {
        int score = 0;
        int left = 0;
        int right = s.length() - 1;

        while (left <= right) {
            char l = s.charAt(left);
            char r = s.charAt(right);

            if (l == r) {
                if (left == right) {
                    score += 1;
                } else {
                    score += 2;
                }
            }

            left++;
            right--;
        }

        return score;
    }
}