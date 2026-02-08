class Solution {
    public boolean areSentencesSimilar(String sentence1, String sentence2) {
        String[] words1 = sentence1.split(" ");
        String[] words2 = sentence2.split(" ");

        int n1 = words1.length;
        int n2 = words2.length;

        if (n1 > n2) {
            String[] tempWords = words1;
            words1 = words2;
            words2 = tempWords;
            int tempN = n1;
            n1 = n2;
            n2 = tempN;
        }

        int i = 0;
        int j = 0;

        while (i < n1 && j < n2 && words1[i].equals(words2[j])) {
            i++;
            j++;
        }

        if (i == n1) {
            return true;
        }

        int k = n1 - 1;
        int l = n2 - 1;

        while (k >= i && l >= j && words1[k].equals(words2[l])) {
            k--;
            l--;
        }

        return i > k;
    }
}