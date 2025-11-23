import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

class Solution {
    public String reformatDate(String date) {
        String[] parts = date.split(" ");
        String day = parts[0];
        String month = parts[1];
        String year = parts[2];

        day = day.substring(0, day.length() - 2);

        String inputDate = day + " " + month + " " + year;

        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("d MMM yyyy");
        LocalDate localDate = LocalDate.parse(inputDate, inputFormatter);

        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return localDate.format(outputFormatter);
    }
}