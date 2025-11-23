class Solution {
    public int maxNumberOfBalloons(String text) {
        int[] charCounts = new int[26];
        for (char c : text.toCharArray()) {
            charCounts[c - 'a']++;
        }

        int countB = charCounts['b' - 'a'];
        int countA = charCounts['a' - 'a'];
        int countL = charCounts['l' - 'a'];
        int countO = charCounts['o' - 'a'];
        int countN = charCounts['n' - 'a'];

        int balloons = Integer.MAX_VALUE;

        balloons = Math.min(balloons, countB);
        balloons = Math.min(balloons, countA);
        balloons = Math.min(balloons, countL / 2);
        balloons = Math.min(balloons, countO / 2);
        balloons = Math.min(balloons, countN);

        return balloons;
    }
}