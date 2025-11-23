import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public String findReplaceString(String s, int[] indices, String[] sources, String[] targets) {
        int n = s.length();
        int m = indices.length;
        Integer[] order = new Integer[m];
        for (int i = 0; i < m; i++) {
            order[i] = i;
        }
        Arrays.sort(order, Comparator.comparingInt(i -> indices[i]));

        StringBuilder sb = new StringBuilder();
        int cur = 0;
        for (int i = 0; i < m; i++) {
            int idx = order[i];
            int index = indices[idx];
            String source = sources[idx];
            String target = targets[idx];

            sb.append(s.substring(cur, index));
            if (s.substring(index).startsWith(source)) {
                sb.append(target);
                cur = index + source.length();
            } else {
                sb.append(s.substring(index, index + 1));
                cur = index + 1;
            }
        }
        sb.append(s.substring(cur));
        return sb.toString();
    }
}