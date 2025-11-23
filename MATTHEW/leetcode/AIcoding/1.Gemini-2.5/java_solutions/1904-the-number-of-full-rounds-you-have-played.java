class Solution {
    public int numberOfRounds(String startTime, String finishTime) {
        int startH = Integer.parseInt(startTime.substring(0, 2));
        int startM = Integer.parseInt(startTime.substring(3, 5));
        int finishH = Integer.parseInt(finishTime.substring(0, 2));
        int finishM = Integer.parseInt(finishTime.substring(3, 5));

        int startTotalMinutes = startH * 60 + startM;
        int finishTotalMinutes = finishH * 60 + finishM;

        if (finishTotalMinutes < startTotalMinutes) {
            finishTotalMinutes += 24 * 60;
        }

        int firstRoundStart;
        if (startTotalMinutes % 15 != 0) {
            firstRoundStart = startTotalMinutes - (startTotalMinutes % 15) + 15;
        } else {
            firstRoundStart = startTotalMinutes;
        }

        int lastRoundStart = finishTotalMinutes - 15;
        lastRoundStart = (lastRoundStart / 15) * 15;

        if (firstRoundStart > lastRoundStart) {
            return 0;
        }

        return (lastRoundStart - firstRoundStart) / 15 + 1;
    }
}