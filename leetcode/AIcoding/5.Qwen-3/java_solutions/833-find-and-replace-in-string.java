public class Solution {

import java.util.*;

public class Solution {
    public String findReplaceString(String S, int[] indices, String[] sources, String[] targets) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < indices.length; i++) {
            map.put(indices[i], i);
        }
        List<int[]> list = new ArrayList<>();
        for (int i : map.keySet()) {
            list.add(new int[]{i, map.get(i)});
        }
        Collections.sort(list, (a, b) -> b[0] - a[0]);
        for (int[] item : list) {
            int index = item[0];
            int pos = item[1];
            if (S.startsWith(sources[pos], index)) {
                S = S.substring(0, index) + targets[pos] + S.substring(index + sources[pos].length());
            }
        }
        return S;
    }
}
}