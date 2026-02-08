class Solution {
    public boolean isValidWord(String word) {
        if (word == null || word.isEmpty()) {
            return true;
        }

        int balance = 0;
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            if (c == 'a') {
                balance++;
            } else if (c == 'b') {
                if (balance > 0 && i + 1 < word.length() && word.charAt(i + 1) == 'c') {
                    balance--;
                    i++;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }

        return balance == 0;
    }
}