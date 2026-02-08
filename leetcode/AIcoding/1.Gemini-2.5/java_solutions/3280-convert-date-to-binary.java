import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

class Solution {
    public String convertDateToBinary(String date) {
        LocalDate localDate = LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
        int year = localDate.getYear();
        int month = localDate.getMonthValue();
        int day = localDate.getDayOfMonth();
        int combinedValue = year * 10000 + month * 100 + day;
        return Integer.toBinaryString(combinedValue);
    }
}