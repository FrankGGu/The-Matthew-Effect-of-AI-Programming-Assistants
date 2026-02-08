import java.util.*;

class Solution {
    public long maxEdgeSum(int[] edge1, int[] edge2) {
        int n = edge1.length;
        long sum = 0;
        List<Integer> diff1 = new ArrayList<>();
        List<Integer> diff2 = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (edge1[i] == edge2[i]) {
                sum += edge1[i];
            } else {
                sum += edge1[i] + edge2[i];
                if (edge1[i] > edge2[i]) {
                    diff1.add(edge1[i] - edge2[i]);
                } else {
                    diff2.add(edge2[i] - edge1[i]);
                }
            }
        }

        Collections.sort(diff1, Collections.reverseOrder());
        Collections.sort(diff2, Collections.reverseOrder());

        long reduce = 0;
        for (int i = 0; i < diff1.size() && i < diff2.size(); i++) {
            reduce += diff1.get(i) + diff2.get(i);
        }

        return sum - reduce;
    }
}