class Solution {
    public boolean canBeEqual(String target, String arr) {
        int[] count = new int[26];
        for (char c : target.toCharArray()) {
            count[c - 'a']++;
        }
        for (char c : arr.toCharArray()) {
            count[c - 'a']--;
        }
        for (int num : count) {
            if (num != 0) {
                return false;
            }
        }
        return true;
    }
}