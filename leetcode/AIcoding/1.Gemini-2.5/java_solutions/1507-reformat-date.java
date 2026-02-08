import java.util.HashMap;
import java.util.Map;

class Solution {
    public String reformatDate(String date) {
        Map<String, String> monthMap = new HashMap<>();
        monthMap.put("Jan", "01");
        monthMap.put("Feb", "02");
        monthMap.put("Mar", "03");
        monthMap.put("Apr", "04");
        monthMap.put("May", "05");
        monthMap.put("Jun", "06");
        monthMap.put("Jul", "07");
        monthMap.put("Aug", "08");
        monthMap.put("Sep", "09");
        monthMap.put("Oct", "10");
        monthMap.put("Nov", "11");
        monthMap.put("Dec", "12");

        String[] parts = date.split(" ");

        String dayPart = parts[0];
        String monthPart = parts[1];
        String yearPart = parts[2];

        String dayWithoutSuffix = dayPart.substring(0, dayPart.length() - 2);
        int dayInt = Integer.parseInt(dayWithoutSuffix);
        String formattedDay = String.format("%02d", dayInt);

        String formattedMonth = monthMap.get(monthPart);

        String formattedYear = yearPart;

        return formattedYear + "-" + formattedMonth + "-" + formattedDay;
    }
}