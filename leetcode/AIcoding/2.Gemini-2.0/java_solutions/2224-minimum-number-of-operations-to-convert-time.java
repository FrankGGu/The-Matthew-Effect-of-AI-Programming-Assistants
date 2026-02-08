class Solution {
    public int convertTime(String current, String correct) {
        int currentMinutes = Integer.parseInt(current.substring(0, 2)) * 60 + Integer.parseInt(current.substring(3, 5));
        int correctMinutes = Integer.parseInt(correct.substring(0, 2)) * 60 + Integer.parseInt(correct.substring(3, 5));
        int diff = correctMinutes - currentMinutes;
        if (diff < 0) {
            return 0;
        }
        int count = 0;
        count += diff / 60;
        diff %= 60;
        count += diff / 15;
        diff %= 15;
        count += diff / 5;
        diff %= 5;
        count += diff;
        return count;
    }
}