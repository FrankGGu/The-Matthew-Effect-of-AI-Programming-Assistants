class Solution {
    public boolean areNumbersAscending(String s) {
        String[] words = s.split(" ");
        int prev = -1;
        for (String word : words) {
            try {
                int num = Integer.parseInt(word);
                if (num <= prev) {
                    return false;
                }
                prev = num;
            } catch (NumberFormatException e) {
                // Not a number, ignore
            }
        }
        return true;
    }
}