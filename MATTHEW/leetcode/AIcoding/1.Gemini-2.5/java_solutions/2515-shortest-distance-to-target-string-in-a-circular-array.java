class Solution {
    public int shortestDistance(String[] words, String target, int startIndex) {
        int n = words.length;
        int minSteps = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            if (words[i].equals(target)) {
                int dist1 = Math.abs(i - startIndex);
                int dist2 = n - dist1;
                minSteps = Math.min(minSteps, Math.min(dist1, dist2));
            }
        }

        return minSteps;
    }
}