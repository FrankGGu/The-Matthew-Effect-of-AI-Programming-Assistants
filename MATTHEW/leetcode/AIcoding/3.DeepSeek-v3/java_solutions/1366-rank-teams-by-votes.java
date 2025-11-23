class Solution {
    public String rankTeams(String[] votes) {
        if (votes.length == 0) return "";
        int n = votes[0].length();
        int[][] count = new int[26][n + 1];
        for (int i = 0; i < 26; i++) {
            count[i][n] = i;
        }
        for (String vote : votes) {
            for (int i = 0; i < vote.length(); i++) {
                count[vote.charAt(i) - 'A'][i]--;
            }
        }
        Arrays.sort(count, (a, b) -> {
            for (int i = 0; i < n; i++) {
                if (a[i] != b[i]) {
                    return a[i] - b[i];
                }
            }
            return a[n] - b[n];
        });
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            sb.append((char) (count[i][n] + 'A'));
        }
        return sb.toString();
    }
}