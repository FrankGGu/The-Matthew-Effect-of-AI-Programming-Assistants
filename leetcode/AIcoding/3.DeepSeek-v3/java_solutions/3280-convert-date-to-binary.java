class Solution {
    public String dateToBinary(String date) {
        String[] parts = date.split("-");
        int year = Integer.parseInt(parts[0]);
        int month = Integer.parseInt(parts[1]);
        int day = Integer.parseInt(parts[2]);

        String yearBinary = String.format("%14s", Integer.toBinaryString(year)).replace(' ', '0');
        String monthBinary = String.format("%4s", Integer.toBinaryString(month)).replace(' ', '0');
        String dayBinary = String.format("%5s", Integer.toBinaryString(day)).replace(' ', '0');

        return yearBinary + monthBinary + dayBinary;
    }
}