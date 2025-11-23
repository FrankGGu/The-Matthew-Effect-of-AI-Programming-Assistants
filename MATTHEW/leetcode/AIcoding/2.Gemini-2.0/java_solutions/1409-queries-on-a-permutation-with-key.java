import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] processQueries(int[] queries, int m) {
        List<Integer> p = new ArrayList<>();
        for (int i = 1; i <= m; i++) {
            p.add(i);
        }
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int query = queries[i];
            int index = p.indexOf(query);
            result[i] = index;
            p.remove(index);
            p.add(0, query);
        }
        return result;
    }
}