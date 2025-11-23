class Solution {
    public String vowelsGame(String s) {
        int scoreA = 0, scoreB = 0;
        String vowels = "aeiouAEIOU";
        for (int i = 0; i < s.length(); i++) {
            if (vowels.indexOf(s.charAt(i)) != -1) {
                if (i % 2 == 0) {
                    scoreA++;
                } else {
                    scoreB++;
                }
            }
        }
        return scoreA > scoreB ? "A" : scoreB > scoreA ? "B" : "Tie";
    }
}