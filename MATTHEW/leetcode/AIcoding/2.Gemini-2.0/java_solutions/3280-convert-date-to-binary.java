class Solution {
    public String convertDateToBinary(String date) {
        String[] parts = date.split(" ");
        int day = Integer.parseInt(parts[1].substring(0, parts[1].length() - 2));
        int month = 0;
        switch (parts[0]) {
            case "Jan": month = 1; break;
            case "Feb": month = 2; break;
            case "Mar": month = 3; break;
            case "Apr": month = 4; break;
            case "May": month = 5; break;
            case "Jun": month = 6; break;
            case "Jul": month = 7; break;
            case "Aug": month = 8; break;
            case "Sep": month = 9; break;
            case "Oct": month = 10; break;
            case "Nov": month = 11; break;
            case "Dec": month = 12; break;
        }
        int year = Integer.parseInt(parts[2]);

        String dayBinary = String.format("%5s", Integer.toBinaryString(day)).replace(' ', '0');
        String monthBinary = String.format("%4s", Integer.toBinaryString(month)).replace(' ', '0');
        String yearBinary = String.format("%12s", Integer.toBinaryString(year)).replace(' ', '0');

        return yearBinary + monthBinary + dayBinary;
    }
}