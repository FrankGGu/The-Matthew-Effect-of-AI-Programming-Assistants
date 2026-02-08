class Solution {
    public boolean makeEqual(String[] words) {
        int[] count = new int[26];
        for (String word : words) {
            for (char c : word.toCharArray()) {
                count[c - 'a']++;
            }
        }
        int len = words.length;
        for (int c : count) {
            if (c % len != 0) {
                return false;
            }
        }
        return true;
    }
}