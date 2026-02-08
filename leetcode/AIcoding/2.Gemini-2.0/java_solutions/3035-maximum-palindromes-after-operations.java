class Solution {
    public int maxPalindromesAfterOperations(String[] words) {
        int[] count = new int[26];
        int totalLength = 0;
        for (String word : words) {
            totalLength += word.length();
            for (char c : word.toCharArray()) {
                count[c - 'a']++;
            }
        }

        int oddCount = 0;
        for (int i = 0; i < 26; i++) {
            oddCount += count[i] % 2;
        }

        int result = 0;
        Arrays.sort(words, (a, b) -> a.length() - b.length());

        for (String word : words) {
            int len = word.length();
            if (totalLength >= len) {
                if (len % 2 == 0) {
                    if (oddCount <= totalLength - len) {
                        result++;
                        totalLength -= len;
                    }
                } else {
                    if (oddCount <= totalLength - len + 1) {
                        result++;
                        totalLength -= len;
                        oddCount--;
                    }
                }
            }
        }
        return result;
    }
}