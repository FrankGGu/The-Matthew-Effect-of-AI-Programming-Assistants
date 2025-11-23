class Solution {
    public int addMinimum(String word) {
        int count = 0;
        char prev = ' ';
        for (char c : word.toCharArray()) {
            while (prev != ' ' && prev + 1 != c && prev - 1 != c) {
                count++;
                prev = (char) (prev + 1);
            }
            prev = c;
        }
        while (prev != ' ') {
            count++;
            prev = (char) (prev + 1);
        }
        return count;
    }
}