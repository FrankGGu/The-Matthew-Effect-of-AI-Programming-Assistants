class Solution {
    public int maxRepeating(String sequence, String word) {
        int count = 0;
        StringBuilder repeatedWordBuilder = new StringBuilder();
        repeatedWordBuilder.append(word);

        while (sequence.contains(repeatedWordBuilder.toString())) {
            count++;
            repeatedWordBuilder.append(word);
        }

        return count;
    }
}