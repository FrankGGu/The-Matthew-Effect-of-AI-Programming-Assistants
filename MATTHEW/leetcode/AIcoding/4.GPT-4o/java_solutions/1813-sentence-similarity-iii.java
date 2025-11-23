class Solution {
    public boolean areSentencesSimilar(String sentence1, String sentence2) {
        String[] words1 = sentence1.split(" ");
        String[] words2 = sentence2.split(" ");
        int n1 = words1.length, n2 = words2.length;

        if (n1 > n2) {
            return areSentencesSimilar(sentence2, sentence1);
        }

        if (n1 == n2) {
            return sentence1.equals(sentence2);
        }

        int i = 0, j = 0;

        while (i < n1 && words1[i].equals(words2[j])) {
            i++;
            j++;
        }

        while (j < n2 && words1[n1 - 1 - (n2 - j - 1)].equals(words2[n2 - 1 - j])) {
            j++;
        }

        return i + j == n2;
    }
}