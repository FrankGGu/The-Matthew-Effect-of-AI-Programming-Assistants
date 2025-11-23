import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> sortBooks(int[] books) {
        List<Integer> result = new ArrayList<>();
        List<Integer> sorted = new ArrayList<>();

        for (int book : books) {
            int insertIndex = 0;
            while (insertIndex < sorted.size() && sorted.get(insertIndex) < book) {
                insertIndex++;
            }
            sorted.add(insertIndex, book);

            result.add(sorted.get(0));
        }

        return result;
    }
}