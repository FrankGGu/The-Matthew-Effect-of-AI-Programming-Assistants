import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numSpecialEquivGroups(String[] words) {
        Set<String> uniqueSignatures = new HashSet<>();

        for (String word : words) {
            int[] evenCounts = new int[26];
            int[] oddCounts = new int[26];

            for (int i = 0; i < word.length(); i++) {
                char c = word.charAt(i);
                if (i % 2 == 0) {
                    evenCounts[c - 'a']++;
                } else {
                    oddCounts[c - 'a']++;
                }
            }

            StringBuilder signatureBuilder = new StringBuilder();
            for (int count : evenCounts) {
                signatureBuilder.append(count).append(",");
            }
            signatureBuilder.append("#");
            for (int count : oddCounts) {
                signatureBuilder.append(count).append(",");
            }

            uniqueSignatures.add(signatureBuilder.toString());
        }

        return uniqueSignatures.size();
    }
}