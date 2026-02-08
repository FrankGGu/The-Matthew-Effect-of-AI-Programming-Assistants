class Solution {
    public int numberOfRounds(String startTime, String finishTime) {
        int startMinutes = convertToMinutes(startTime);
        int finishMinutes = convertToMinutes(finishTime);

        if (finishMinutes < startMinutes) {
            finishMinutes += 24 * 60;
        }

        startMinutes = (startMinutes + 15) / 15 * 15;
        finishMinutes = finishMinutes / 15 * 15;

        if (startMinutes >= finishMinutes) {
            return 0;
        }

        return (finishMinutes - startMinutes) / 15;
    }

    private int convertToMinutes(String time) {
        String[] parts = time.split(":");
        return Integer.parseInt(parts[0]) * 60 + Integer.parseInt(parts[1]);
    }
}