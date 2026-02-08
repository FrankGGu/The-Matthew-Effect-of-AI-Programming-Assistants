class Solution {
    public String getHint(String secret, String guess) {
        int bulls = 0;
        int cows = 0;
        int[] freq = new int[10];

        for (int i = 0; i < secret.length(); i++) {
            if (secret.charAt(i) == guess.charAt(i)) {
                bulls++;
            } else {
                freq[secret.charAt(i) - '0']++;
            }
        }

        for (int i = 0; i < guess.length(); i++) {
            if (secret.charAt(i) != guess.charAt(i)) {
                if (freq[guess.charAt(i) - '0'] > 0) {
                    cows++;
                    freq[guess.charAt(i) - '0']--;
                }
            }
        }

        return bulls + "A" + cows + "B";
    }
}