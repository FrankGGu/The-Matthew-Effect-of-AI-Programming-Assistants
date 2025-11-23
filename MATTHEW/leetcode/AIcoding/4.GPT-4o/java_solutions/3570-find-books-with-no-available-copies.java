import java.util.*;

public class Solution {
    public List<String> findBooksWithNoAvailableCopies(List<String> books, List<Integer> copies) {
        List<String> result = new ArrayList<>();
        for (int i = 0; i < books.size(); i++) {
            if (copies.get(i) == 0) {
                result.add(books.get(i));
            }
        }
        return result;
    }
}