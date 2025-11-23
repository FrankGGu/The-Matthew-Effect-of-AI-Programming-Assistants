public class Solution {

import java.util.*;

public class Solution {
    public String convertDateToBinary(String date) {
        String[] parts = date.split("-");
        int year = Integer.parseInt(parts[0]);
        int month = Integer.parseInt(parts[1]);
        int day = Integer.parseInt(parts[2]);

        StringBuilder result = new StringBuilder();
        result.append(Integer.toBinaryString(year)).append(" ");
        result.append(Integer.toBinaryString(month)).append(" ");
        result.append(Integer.toBinaryString(day));

        return result.toString();
    }
}
}