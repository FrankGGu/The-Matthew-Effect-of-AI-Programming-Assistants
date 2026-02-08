public class Solution {

import java.util.*;

public class Solution {
    public int minAreaRectangles(int[][] rects) {
        Map<Integer, Set<Integer>> xToY = new HashMap<>();
        for (int[] rect : rects) {
            int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];
            xToY.putIfAbsent(x1, new HashSet<>());
            xToY.get(x1).add(y1);
            xToY.putIfAbsent(x1, new HashSet<>());
            xToY.get(x1).add(y2);
            xToY.putIfAbsent(x2, new HashSet<>());
            xToY.get(x2).add(y1);
            xToY.putIfAbsent(x2, new HashSet<>());
            xToY.get(x2).add(y2);
        }

        Map<String, Integer> pointMap = new HashMap<>();
        int index = 0;
        for (int x : xToY.keySet()) {
            for (int y : xToY.get(x)) {
                pointMap.put(x + "," + y, index++);
            }
        }

        UnionFind uf = new UnionFind(index);
        for (int[] rect : rects) {
            int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];
            int a = pointMap.get(x1 + "," + y1);
            int b = pointMap.get(x1 + "," + y2);
            int c = pointMap.get(x2 + "," + y1);
            int d = pointMap.get(x2 + "," + y2);
            uf.union(a, b);
            uf.union(a, c);
            uf.union(a, d);
        }

        Map<Integer, Set<Integer>> parentToPoints = new HashMap<>();
        for (int i = 0; i < index; i++) {
            int parent = uf.find(i);
            parentToPoints.putIfAbsent(parent, new HashSet<>());
            parentToPoints.get(parent).add(i);
        }

        int minArea = Integer.MAX_VALUE;
        for (Set<Integer> points : parentToPoints.values()) {
            if (points.size() < 4) continue;
            List<Integer> list = new ArrayList<>(points);
            for (int i = 0; i < list.size(); i++) {
                for (int j = i + 1; j < list.size(); j++) {
                    int p1 = list.get(i);
                    int p2 = list.get(j);
                    String[] p1Split = ((String) pointMap.keySet().toArray()[p1]).split(",");
                    String[] p2Split = ((String) pointMap.keySet().toArray()[p2]).split(",");
                    int x1 = Integer.parseInt(p1Split[0]);
                    int y1 = Integer.parseInt(p1Split[1]);
                    int x2 = Integer.parseInt(p2Split[0]);
                    int y2 = Integer.parseInt(p2Split[1]);
                    if (x1 != x2 && y1 != y2) {
                        int area = Math.abs(x1 - x2) * Math.abs(y1 - y2);
                        minArea = Math.min(minArea, area);
                    }
                }
            }
        }

        return minArea == Integer.MAX_VALUE ? 0 : minArea;
    }

    static class UnionFind {
        int[] parent;

        UnionFind(int size) {
            parent = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
            }
        }

        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
            }
        }
    }
}
}