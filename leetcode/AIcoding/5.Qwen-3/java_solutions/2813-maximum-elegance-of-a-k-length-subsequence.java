public class Solution {

import java.util.*;

public class Solution {
    public long maximumElegance(int[] types, int k) {
        int n = types.length;
        int[][] typeCount = new int[n][2];
        for (int i = 0; i < n; i++) {
            typeCount[i][0] = types[i];
            typeCount[i][1] = i;
        }
        Arrays.sort(typeCount, (a, b) -> {
            if (b[0] != a[0]) return b[0] - a[0];
            return a[1] - b[1];
        });

        Map<Integer, Integer> countMap = new HashMap<>();
        List<Integer> unique = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            int type = typeCount[i][0];
            if (!countMap.containsKey(type)) {
                countMap.put(type, 1);
                unique.add(type);
            } else {
                countMap.put(type, countMap.get(type) + 1);
            }
        }

        List<int[]> sorted = new ArrayList<>();
        for (int type : unique) {
            sorted.add(new int[]{type, countMap.get(type)});
        }
        sorted.sort((a, b) -> b[1] - a[1]);

        List<Integer> selected = new ArrayList<>();
        int total = 0;
        for (int i = 0; i < Math.min(k, sorted.size()); i++) {
            int type = sorted.get(i)[0];
            int cnt = sorted.get(i)[1];
            selected.add(type);
            total += cnt;
        }

        if (selected.size() == k) {
            return total;
        }

        List<Integer> extra = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            int type = typeCount[i][0];
            if (!selected.contains(type)) {
                extra.add(type);
            }
        }

        Collections.sort(extra);

        int[] freq = new int[100001];
        for (int i = 0; i < k; i++) {
            int type = typeCount[i][0];
            freq[type]++;
        }

        for (int i = 0; i < extra.size() && selected.size() < k; i++) {
            int type = extra.get(i);
            if (freq[type] > 1) {
                selected.add(type);
                freq[type]--;
            }
        }

        long result = 0;
        for (int type : selected) {
            result += type;
        }

        return result;
    }
}
}