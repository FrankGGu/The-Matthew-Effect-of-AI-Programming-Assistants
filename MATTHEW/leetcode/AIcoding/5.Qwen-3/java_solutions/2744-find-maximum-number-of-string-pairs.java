public class Solution {
    public int maximumNumberOfStringPairsYouCanForm(String[] words) {
        int[] count = new int[26];
        int pairs = 0;

        for (String word : words) {
            char first = word.charAt(0);
            char second = word.charAt(1);
            if (count[second - 'a'] > 0) {
                pairs++;
                count[second - 'a']--;
            } else {
                count[first - 'a']++;
            }
        }

        return pairs;
    }
}