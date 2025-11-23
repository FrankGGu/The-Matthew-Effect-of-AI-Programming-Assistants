class Solution {
    public String getHint(String secret, String guess) {
        int[] countS = new int[10];
        int[] countG = new int[10];
        int bulls = 0;

        for (int i = 0; i < secret.length(); i++) {
            if (secret.charAt(i) == guess.charAt(i)) {
                bulls++;
            } else {
                countS[secret.charAt(i) - '0']++;
                countG[guess.charAt(i) - '0']++;
            }
        }

        int cows = 0;
        for (int i = 0; i < 10; i++) {
            cows += Math.min(countS[i], countG[i]);
        }

        return bulls + "A" + cows + "B";
    }
}