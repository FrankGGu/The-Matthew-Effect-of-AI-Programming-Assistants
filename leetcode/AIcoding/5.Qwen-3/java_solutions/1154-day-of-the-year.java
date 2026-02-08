public class Solution {

import java.time.LocalDate;

public class Solution {
    public int dayOfYear(String date) {
        LocalDate localDate = LocalDate.parse(date);
        return localDate.getDayOfYear();
    }
}
}