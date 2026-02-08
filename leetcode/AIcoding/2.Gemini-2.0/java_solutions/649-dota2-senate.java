class Solution {
    public String predictPartyVictory(String senate) {
        int radiant = 0;
        int dire = 0;
        for (char c : senate.toCharArray()) {
            if (c == 'R') {
                radiant++;
            } else {
                dire++;
            }
        }

        boolean[] banned = new boolean[senate.length()];
        int radiantBan = 0;
        int direBan = 0;

        while (radiant > 0 && dire > 0) {
            for (int i = 0; i < senate.length(); i++) {
                if (banned[i]) continue;

                if (senate.charAt(i) == 'R') {
                    if (radiantBan > 0) {
                        radiantBan--;
                        banned[i] = true;
                        radiant--;
                    } else {
                        direBan++;
                    }
                } else {
                    if (direBan > 0) {
                        direBan--;
                        banned[i] = true;
                        dire--;
                    } else {
                        radiantBan++;
                    }
                }
            }
        }

        return radiant > 0 ? "Radiant" : "Dire";
    }
}