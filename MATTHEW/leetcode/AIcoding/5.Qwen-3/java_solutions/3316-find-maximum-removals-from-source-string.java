public class Solution {

import java.util.*;

public class Solution {
    public int maximumRemovals(int[] source, int[] target) {
        int n = source.length;
        int m = target.length;
        int[] indexMap = new int[100000];
        Arrays.fill(indexMap, -1);
        for (int i = 0; i < m; i++) {
            indexMap[target[i]] = i;
        }
        List<Integer> positions = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (indexMap[source[i]] != -1) {
                positions.add(i);
            }
        }
        int[] targetIndices = new int[m];
        for (int i = 0; i < m; i++) {
            targetIndices[i] = indexMap[target[i]];
        }
        int count = 0;
        int pos = 0;
        for (int i = 0; i < positions.size(); i++) {
            if (pos < m && positions.get(i) == targetIndices[pos]) {
                count++;
                pos++;
            }
        }
        return count;
    }
}
}