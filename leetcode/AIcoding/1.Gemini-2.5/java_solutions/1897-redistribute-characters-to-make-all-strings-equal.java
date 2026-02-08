class Solution {
    public boolean makeEqual(String[] words) {
        int[] charCounts = new int[26];
        int n = words.length;

        for (String word : words) {
            for (char c : word.toCharArray()) {
                charCounts[c - 'a']++;
            }
        }

        for (int count : charCounts) {
            if (count % n != 0) {
                return false;
            }
        }

        return true;
    }
}