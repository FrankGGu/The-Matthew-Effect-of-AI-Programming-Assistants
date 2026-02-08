class Solution {
    public boolean areSentencesSimilar(String sentence1, String sentence2) {
        String[] words1 = sentence1.split(" ");
        String[] words2 = sentence2.split(" ");
        if (words1.length < words2.length) {
            return areSentencesSimilarHelper(words1, words2);
        } else {
            return areSentencesSimilarHelper(words2, words1);
        }
    }

    private boolean areSentencesSimilarHelper(String[] shorter, String[] longer) {
        int m = shorter.length;
        int n = longer.length;
        int i = 0;
        while (i < m && shorter[i].equals(longer[i])) {
            i++;
        }
        while (i < m && shorter[i].equals(longer[n - m + i])) {
            i++;
        }
        return i == m;
    }
}