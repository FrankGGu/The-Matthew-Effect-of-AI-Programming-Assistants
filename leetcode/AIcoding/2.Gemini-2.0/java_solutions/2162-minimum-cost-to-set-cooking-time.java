class Solution {
    public int minCostSetTime(int startAt, int moveCost, int pushCost, int targetSeconds) {
        int minCost = Integer.MAX_VALUE;
        int minutes = targetSeconds / 60;
        int seconds = targetSeconds % 60;

        if (minutes > 99) {
            minutes = 99;
            seconds = 59;
        }

        if (minutes >= 0 && minutes <= 99 && seconds >= 0 && seconds <= 59) {
            minCost = Math.min(minCost, calculateCost(startAt, moveCost, pushCost, minutes, seconds));
        }

        if (targetSeconds >= 60 && targetSeconds <= 6059) {
            minutes = (targetSeconds - 60) / 60;
            seconds = (targetSeconds - 60) % 60 + 60;
            if (minutes >= 0 && minutes <= 99 && seconds >= 60 && seconds <= 119) {
                seconds -= 60;
                minutes++;
                if(minutes <= 99)
                    minCost = Math.min(minCost, calculateCost(startAt, moveCost, pushCost, minutes, seconds));
            }
        }

        if (targetSeconds >= 60) {
            minutes = (targetSeconds - 1) / 60;
            seconds = (targetSeconds - 1) % 60 + 1;
            if (minutes >= 0 && minutes <= 99 && seconds >= 1 && seconds <= 60 && (targetSeconds - 1) >= 0) {
                seconds--;
                minutes = (targetSeconds-1) / 60;
                seconds = (targetSeconds-1) % 60;
                if(minutes <= 99)
                    minCost = Math.min(minCost, calculateCost(startAt, moveCost, pushCost, minutes, seconds));
            }
        }

        return minCost;
    }

    private int calculateCost(int startAt, int moveCost, int pushCost, int minutes, int seconds) {
        String time = String.format("%02d%02d", minutes, seconds);
        int cost = 0;
        int current = startAt;
        boolean leadingZero = true;

        for (int i = 0; i < time.length(); i++) {
            char digitChar = time.charAt(i);
            int digit = digitChar - '0';

            if (leadingZero && digit == 0 && (i == 0 || i == 2)) {
                continue;
            } else {
                leadingZero = false;
                if (current != digit) {
                    cost += moveCost;
                    current = digit;
                }
                cost += pushCost;
            }
        }

        return cost;
    }
}