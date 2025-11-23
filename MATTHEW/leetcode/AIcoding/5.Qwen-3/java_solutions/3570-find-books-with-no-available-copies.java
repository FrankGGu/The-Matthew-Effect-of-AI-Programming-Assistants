public class Solution {

import java.util.*;

public class Solution {
    public List<String> findBooksWithNoAvailableCopies(List<Map<String, Object>> books) {
        List<String> result = new ArrayList<>();
        for (Map<String, Object> book : books) {
            int availableCopies = (Integer) book.get("availableCopies");
            if (availableCopies == 0) {
                result.add((String) book.get("title"));
            }
        }
        return result;
    }
}
}