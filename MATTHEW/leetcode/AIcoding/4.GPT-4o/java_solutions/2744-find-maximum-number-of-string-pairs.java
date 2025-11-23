class Solution {
    public int maximumNumberOfStringPairs(String[] words) {
        Set<String> seen = new HashSet<>();
        int count = 0;

        for (String word : words) {
            String rev = new StringBuilder(word).reverse().toString();
            if (seen.contains(rev)) {
                count++;
            }
            seen.add(word);
        }

        return count;
    }
}