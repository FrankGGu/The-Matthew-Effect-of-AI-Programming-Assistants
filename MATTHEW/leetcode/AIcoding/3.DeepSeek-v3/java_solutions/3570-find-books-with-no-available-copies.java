import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> findNoAvailableCopies(String[] books, int[] availableCopies) {
        List<String> result = new ArrayList<>();
        for (int i = 0; i < books.length; i++) {
            if (availableCopies[i] == 0) {
                result.add(books[i]);
            }
        }
        return result;
    }
}