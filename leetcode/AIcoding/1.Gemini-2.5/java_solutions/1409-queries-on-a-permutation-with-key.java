import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] processQueries(int[] queries, int m) {
        List<Integer> p = new ArrayList<>();
        for (int i = 1; i <= m; i++) {
            p.add(i);
        }

        int[] results = new int[queries.length];

        for (int i = 0; i < queries.length; i++) {
            int queryValue = queries[i];
            int index = p.indexOf(queryValue);
            results[i] = index;

            p.remove(index);
            p.add(0, queryValue);
        }

        return results;
    }
}