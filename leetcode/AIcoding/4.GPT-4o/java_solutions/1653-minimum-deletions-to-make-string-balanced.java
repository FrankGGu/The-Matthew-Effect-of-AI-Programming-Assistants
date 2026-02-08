class Solution {
    public int minimumDeletions(String s) {
        int countA = 0, countB = 0;
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                countA++;
            } else {
                countB++;
            }
        }
        int deletions = 0, minDeletions = Math.min(countA, countB);
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                countA--;
            } else {
                deletions++;
            }
            if (deletions > countA) {
                break;
            }
            minDeletions = Math.min(minDeletions, deletions + countA);
        }
        return minDeletions;
    }
}