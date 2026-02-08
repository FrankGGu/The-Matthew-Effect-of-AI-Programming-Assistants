class Solution {
    public int minimumDeletions(String s) {
        int bCount = 0;
        int deletions = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == 'b') {
                bCount++;
            } else {
                deletions = Math.min(deletions + 1, bCount);
            }
        }
        return deletions;
    }
}