class Solution {
    public int removeAlmostEqualCharacters(String word) {
        int n = word.length();
        int count = 0;
        for (int i = 1; i < n; ) {
            char prev = word.charAt(i - 1);
            char curr = word.charAt(i);
            if (Math.abs(prev - curr) <= 1) {
                count++;
                i += 2;
            } else {
                i++;
            }
        }
        return count;
    }
}