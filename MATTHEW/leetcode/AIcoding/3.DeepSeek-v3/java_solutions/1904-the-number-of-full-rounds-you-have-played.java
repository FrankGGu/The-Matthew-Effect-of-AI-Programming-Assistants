class Solution {
    public int numberOfRounds(String loginTime, String logoutTime) {
        int login = parseTime(loginTime);
        int logout = parseTime(logoutTime);

        if (logout < login) {
            logout += 24 * 60;
        }

        int start = (login + 14) / 15 * 15;
        int end = logout / 15 * 15;

        return Math.max(0, (end - start) / 15);
    }

    private int parseTime(String time) {
        String[] parts = time.split(":");
        int hours = Integer.parseInt(parts[0]);
        int minutes = Integer.parseInt(parts[1]);
        return hours * 60 + minutes;
    }
}