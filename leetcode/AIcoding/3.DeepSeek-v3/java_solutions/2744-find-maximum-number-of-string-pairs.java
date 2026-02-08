class Solution {
    public int maximumNumberOfStringPairs(String[] words) {
        int count = 0;
        for (int i = 0; i < words.length; i++) {
            for (int j = i + 1; j < words.length; j++) {
                if (words[i].equals(new StringBuilder(words[j]).reverse().toString())) {
                    count++;
                }
            }
        }
        return count;
    }
}