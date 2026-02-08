class Solution {
    public String reformatDate(String date) {
        String[] parts = date.split(" ");
        String day = parts[0].substring(0, parts[0].length() - 2);
        String month = parts[1];
        String year = parts[2];

        String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        int monthIndex = 0;
        for (int i = 0; i < months.length; i++) {
            if (months[i].equals(month)) {
                monthIndex = i + 1;
                break;
            }
        }

        return String.format("%s-%02d-%02d", year, monthIndex, Integer.parseInt(day));
    }
}