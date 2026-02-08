class Solution {
    public int shortestDistance(String[] words, String target, int startIndex) {
        int n = words.length;
        int minDist = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            if (words[i].equals(target)) {
                int dist = Math.min(Math.abs(i - startIndex), n - Math.abs(i - startIndex));
                minDist = Math.min(minDist, dist);
            }
        }
        return minDist;
    }
}