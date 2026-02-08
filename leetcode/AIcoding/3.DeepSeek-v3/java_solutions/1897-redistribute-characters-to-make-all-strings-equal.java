class Solution {
    public boolean makeEqual(String[] words) {
        int[] count = new int[26];
        for (String word : words) {
            for (char c : word.toCharArray()) {
                count[c - 'a']++;
            }
        }
        int n = words.length;
        for (int num : count) {
            if (num % n != 0) {
                return false;
            }
        }
        return true;
    }
}