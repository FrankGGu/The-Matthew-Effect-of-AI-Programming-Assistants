public class Solution {

import java.util.*;

public class Solution {
    public int maximizeSquareArea(int n, int[] x, int[] y) {
        Map<Integer, List<Integer>> xMap = new HashMap<>();
        Map<Integer, List<Integer>> yMap = new HashMap<>();

        for (int i = 0; i < n; ++i) {
            xMap.computeIfAbsent(x[i], k -> new ArrayList<>()).add(y[i]);
            yMap.computeIfAbsent(y[i], k -> new ArrayList<>()).add(x[i]);
        }

        for (List<Integer> list : xMap.values()) {
            Collections.sort(list);
        }

        for (List<Integer> list : yMap.values()) {
            Collections.sort(list);
        }

        Set<Integer> xSet = new HashSet<>(xMap.keySet());
        Set<Integer> ySet = new HashSet<>(yMap.keySet());

        List<Integer> xList = new ArrayList<>(xSet);
        List<Integer> yList = new ArrayList<>(ySet);

        Collections.sort(xList);
        Collections.sort(yList);

        int maxSide = 0;

        for (int i = 0; i < xList.size(); ++i) {
            int x1 = xList.get(i);
            List<Integer> y1s = xMap.get(x1);
            for (int j = i + 1; j < xList.size(); ++j) {
                int x2 = xList.get(j);
                List<Integer> y2s = xMap.get(x2);
                int minLen = Math.min(y1s.size(), y2s.size());
                int common = 0;
                int p = 0, q = 0;
                while (p < y1s.size() && q < y2s.size()) {
                    if (y1s.get(p).equals(y2s.get(q))) {
                        common++;
                        p++;
                        q++;
                    } else if (y1s.get(p) < y2s.get(q)) {
                        p++;
                    } else {
                        q++;
                    }
                }
                if (common >= 2) {
                    int side = x2 - x1;
                    maxSide = Math.max(maxSide, side);
                }
            }
        }

        for (int i = 0; i < yList.size(); ++i) {
            int y1 = yList.get(i);
            List<Integer> x1s = yMap.get(y1);
            for (int j = i + 1; j < yList.size(); ++j) {
                int y2 = yList.get(j);
                List<Integer> x2s = yMap.get(y2);
                int minLen = Math.min(x1s.size(), x2s.size());
                int common = 0;
                int p = 0, q = 0;
                while (p < x1s.size() && q < x2s.size()) {
                    if (x1s.get(p).equals(x2s.get(q))) {
                        common++;
                        p++;
                        q++;
                    } else if (x1s.get(p) < x2s.get(q)) {
                        p++;
                    } else {
                        q++;
                    }
                }
                if (common >= 2) {
                    int side = y2 - y1;
                    maxSide = Math.max(maxSide, side);
                }
            }
        }

        return maxSide * maxSide;
    }
}
}