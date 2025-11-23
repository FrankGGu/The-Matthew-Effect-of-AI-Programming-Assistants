import java.util.*;

class Solution {
    public List<Integer> findAllPeople(int n, int[][] meetings, int firstPerson) {
        boolean[] knowsSecret = new boolean[n];
        knowsSecret[0] = true;
        knowsSecret[firstPerson] = true;

        Arrays.sort(meetings, (a, b) -> Integer.compare(a[2], b[2]));

        UnionFind uf = new UnionFind(n);

        int i = 0;
        while (i < meetings.length) {
            int currentTime = meetings[i][2];
            Set<Integer> peopleInCurrentTimeSlice = new HashSet<>();

            int j = i;
            while (j < meetings.length && meetings[j][2] == currentTime) {
                int p1 = meetings[j][0];
                int p2 = meetings[j][1];

                uf.union(p1, p2);
                peopleInCurrentTimeSlice.add(p1);
                peopleInCurrentTimeSlice.add(p2);
                j++;
            }

            Set<Integer> rootsKnowingSecret = new HashSet<>();
            for (int person : peopleInCurrentTimeSlice) {
                if (knowsSecret[person]) {
                    rootsKnowingSecret.add(uf.find(person));
                }
            }

            for (int person : peopleInCurrentTimeSlice) {
                if (rootsKnowingSecret.contains(uf.find(person))) {
                    knowsSecret[person] = true;
                } else {
                    uf.reset(person);
                }
            }

            i = j;
        }

        List<Integer> result = new ArrayList<>();
        for (int person = 0; person < n; person++) {
            if (knowsSecret[person]) {
                result.add(person);
            }
        }

        return result;
    }

    static class UnionFind {
        int[] parent;

        public UnionFind(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        public int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        }

        public void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);
            if (rootI != rootJ) {
                parent[rootJ] = rootI;
            }
        }

        public void reset(int i) {
            parent[i] = i;
        }
    }
}