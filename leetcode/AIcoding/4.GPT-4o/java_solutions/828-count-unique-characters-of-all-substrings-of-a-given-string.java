class Solution {
    public int uniqueLetterString(String s) {
        int[] lastIndex = new int[26];
        int result = 0, n = s.length();
        for (int i = 0; i < 26; i++) lastIndex[i] = -1;
        for (int i = 0; i < n; i++) {
            int currentIndex = s.charAt(i) - 'A';
            int left = lastIndex[currentIndex];
            int right = i;
            result += (right - left) * (left + 1);
            lastIndex[currentIndex] = i;
        }
        for (int i = 0; i < 26; i++) {
            int currentIndex = lastIndex[i];
            if (currentIndex != -1) {
                int left = currentIndex;
                int right = n;
                result += (right - left) * (left + 1);
            }
        }
        return result;
    }
}