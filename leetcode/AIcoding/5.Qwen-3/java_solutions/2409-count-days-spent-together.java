public class Solution {

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Solution {
    public int countDaysTogether(String arriveAlice, String departAlice, String arriveBob, String departBob) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");
        LocalDate aStart = LocalDate.parse(arriveAlice, formatter);
        LocalDate aEnd = LocalDate.parse(departAlice, formatter);
        LocalDate bStart = LocalDate.parse(arriveBob, formatter);
        LocalDate bEnd = LocalDate.parse(departBob, formatter);

        LocalDate start = aStart.isAfter(bStart) ? aStart : bStart;
        LocalDate end = aEnd.isBefore(bEnd) ? aEnd : bEnd;

        if (start.isAfter(end)) {
            return 0;
        }

        return (int) (end.toEpochDay() - start.toEpochDay() + 1);
    }
}
}