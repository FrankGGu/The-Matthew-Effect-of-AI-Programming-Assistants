import java.util.*;

public class Solution {
    public List<Integer> findAllPeople(int n, int[][] meetings, int firstPerson) {
        Arrays.sort(meetings, (a, b) -> a[2] - b[2]);
        UnionFind uf = new UnionFind(n);
        uf.union(0, firstPerson);

        int time = 0;
        List<int[]> temp = new ArrayList<>();

        for (int[] meeting : meetings) {
            if (meeting[2] != time) {
                for (int[] m : temp) {
                    if (uf.find(m[0]) == uf.find(m[1])) {
                        continue;
                    }
                    uf.union(m[0], m[1]);
                }
                for (int[] m : temp) {
                    if (uf.find(m[0]) == uf.find(0)) {
                        uf.union(m[0], m[1]);
                    }
                }
                temp.clear();
                time = meeting[2];
            }
            temp.add(meeting);
            uf.union(meeting[0], meeting[1]);
        }

        Set<Integer> result = new HashSet<>();
        for (int i = 0; i < n; i++) {
            if (uf.find(i) == uf.find(0)) {
                result.add(i);
            }
        }

        return new ArrayList<>(result);
    }

    class UnionFind {
        int[] parent;

        public UnionFind(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        public int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        }
    }
}