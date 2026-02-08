class Solution {
    public int balancedString(String s) {
        int[] count = new int[4];
        for (char c : s.toCharArray()) {
            count[getIndex(c)]++;
        }

        int n = s.length();
        int target = n / 4;
        if (count[0] == target && count[1] == target && count[2] == target && count[3] == target) {
            return 0;
        }

        int minLength = n;
        int left = 0;

        for (int right = 0; right < n; right++) {
            count[getIndex(s.charAt(right))]--;
            while (left < n && count[0] <= target && count[1] <= target && 
                   count[2] <= target && count[3] <= target) {
                minLength = Math.min(minLength, right - left + 1);
                count[getIndex(s.charAt(left))]++;
                left++;
            }
        }

        return minLength;
    }

    private int getIndex(char c) {
        switch (c) {
            case 'Q': return 0;
            case 'W': return 1;
            case 'E': return 2;
            case 'R': return 3;
            default: return -1;
        }
    }
}