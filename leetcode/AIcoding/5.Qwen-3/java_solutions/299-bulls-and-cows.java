public class Solution {
    public String getHint(String secret, String guess) {
        int bulls = 0;
        int cows = 0;
        int[] count = new int[10];
        for (int i = 0; i < secret.length(); i++) {
            char s = secret.charAt(i);
            char g = guess.charAt(i);
            if (s == g) {
                bulls++;
            } else {
                count[s - '0']++;
                count[g - '0']--;
            }
        }
        for (int i = 0; i < 10; i++) {
            cows += Math.max(0, count[i]);
        }
        return bulls + "A" + cows + "B";
    }
}