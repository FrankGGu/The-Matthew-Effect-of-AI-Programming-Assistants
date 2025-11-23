class Solution {
    public int maxNumberOfBalloons(String text) {
        int[] count = new int[26];
        for (char c : text.toCharArray()) {
            count[c - 'a']++;
        }
        int min = Integer.MAX_VALUE;
        min = Math.min(min, count['b' - 'a']);
        min = Math.min(min, count['a' - 'a']);
        min = Math.min(min, count['l' - 'a'] / 2);
        min = Math.min(min, count['o' - 'a'] / 2);
        min = Math.min(min, count['n' - 'a']);
        return min;
    }
}