class Solution {
    public int minTimeToType(String word) {
        int time = 0;
        char current = 'a';
        for (char c : word.toCharArray()) {
            int diff = Math.abs(c - current);
            time += Math.min(diff, 26 - diff) + 1;
            current = c;
        }
        return time;
    }
}