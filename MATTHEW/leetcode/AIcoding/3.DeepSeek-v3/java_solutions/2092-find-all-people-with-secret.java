class Solution {
    public List<Integer> findAllPeople(int n, int[][] meetings, int firstPerson) {
        List<Integer> result = new ArrayList<>();
        UnionFind uf = new UnionFind(n);
        uf.union(0, firstPerson);

        Map<Integer, List<int[]>> timeToMeetings = new TreeMap<>();
        for (int[] meeting : meetings) {
            int x = meeting[0], y = meeting[1], time = meeting[2];
            timeToMeetings.computeIfAbsent(time, k -> new ArrayList<>()).add(new int[]{x, y});
        }

        for (int time : timeToMeetings.keySet()) {
            List<int[]> currentMeetings = timeToMeetings.get(time);
            for (int[] meeting : currentMeetings) {
                int x = meeting[0], y = meeting[1];
                uf.union(x, y);
            }

            Set<Integer> visited = new HashSet<>();
            for (int[] meeting : currentMeetings) {
                int x = meeting[0], y = meeting[1];
                if (uf.find(x) == uf.find(0)) {
                    visited.add(x);
                    visited.add(y);
                }
                uf.reset(x);
                uf.reset(y);
            }

            for (int person : visited) {
                uf.union(0, person);
            }
        }

        for (int i = 0; i < n; i++) {
            if (uf.find(i) == uf.find(0)) {
                result.add(i);
            }
        }
        return result;
    }

    class UnionFind {
        private int[] parent;

        public UnionFind(int size) {
            parent = new int[size];
            for (int i = 0; i < size; i++) {
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

        public void reset(int x) {
            parent[x] = x;
        }
    }
}