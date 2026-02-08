class Solution {
    public int numberOfRounds(String startTime, String finishTime) {
        int startHour = Integer.parseInt(startTime.substring(0, 2));
        int startMinute = Integer.parseInt(startTime.substring(3, 5));
        int finishHour = Integer.parseInt(finishTime.substring(0, 2));
        int finishMinute = Integer.parseInt(finishTime.substring(3, 5));

        int startTotalMinutes = startHour * 60 + startMinute;
        int finishTotalMinutes = finishHour * 60 + finishMinute;

        if (finishTotalMinutes < startTotalMinutes) {
            finishTotalMinutes += 24 * 60;
        }

        int startRoundMinutes = (int) Math.ceil(startTotalMinutes / 15.0) * 15;
        int finishRoundMinutes = (int) Math.floor(finishTotalMinutes / 15.0) * 15;

        return (finishRoundMinutes - startRoundMinutes) / 15;
    }
}