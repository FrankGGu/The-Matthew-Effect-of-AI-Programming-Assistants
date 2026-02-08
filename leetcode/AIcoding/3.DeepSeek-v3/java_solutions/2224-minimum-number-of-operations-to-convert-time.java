class Solution {
    public int convertTime(String current, String correct) {
        String[] currentParts = current.split(":");
        String[] correctParts = correct.split(":");

        int currentHour = Integer.parseInt(currentParts[0]);
        int currentMinute = Integer.parseInt(currentParts[1]);
        int correctHour = Integer.parseInt(correctParts[0]);
        int correctMinute = Integer.parseInt(correctParts[1]);

        int currentTotal = currentHour * 60 + currentMinute;
        int correctTotal = correctHour * 60 + correctMinute;
        int diff = correctTotal - currentTotal;

        int operations = 0;
        operations += diff / 60;
        diff %= 60;
        operations += diff / 15;
        diff %= 15;
        operations += diff / 5;
        diff %= 5;
        operations += diff;

        return operations;
    }
}