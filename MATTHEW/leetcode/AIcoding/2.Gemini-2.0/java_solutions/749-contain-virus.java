class Solution {
    private static final int[][] DIRS = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public int containVirus(int[][] isInfected) {
        int m = isInfected.length;
        int n = isInfected[0].length;
        int ans = 0;

        while (true) {
            List<Set<Integer>> regions = new ArrayList<>();
            List<Set<Integer>> frontiers = new ArrayList<>();
            boolean[][] visited = new boolean[m][n];

            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (isInfected[i][j] == 1 && !visited[i][j]) {
                        Set<Integer> region = new HashSet<>();
                        Set<Integer> frontier = new HashSet<>();
                        dfs(isInfected, i, j, visited, region, frontier);
                        regions.add(region);
                        frontiers.add(frontier);
                    }
                }
            }

            if (regions.isEmpty()) break;

            int maxFrontierIndex = 0;
            int maxFrontierSize = 0;
            for (int i = 0; i < frontiers.size(); i++) {
                if (frontiers.get(i).size() > maxFrontierSize) {
                    maxFrontierSize = frontiers.get(i).size();
                    maxFrontierIndex = i;
                }
            }

            ans += walls(regions.get(maxFrontierIndex), m, n);

            for (int i = 0; i < regions.size(); i++) {
                if (i == maxFrontierIndex) {
                    for (int cell : regions.get(i)) {
                        int r = cell / n;
                        int c = cell % n;
                        isInfected[r][c] = -1; // Mark as walled
                    }
                } else {
                    for (int cell : regions.get(i)) {
                        int r = cell / n;
                        int c = cell % n;
                        for (int[] dir : DIRS) {
                            int nr = r + dir[0];
                            int nc = c + dir[1];
                            if (nr >= 0 && nr < m && nc >= 0 && nc < n && isInfected[nr][nc] == 0) {
                                isInfected[nr][nc] = 1;
                            }
                        }
                    }
                }
            }
        }

        return ans;
    }

    private void dfs(int[][] isInfected, int i, int j, boolean[][] visited, Set<Integer> region, Set<Integer> frontier) {
        int m = isInfected.length;
        int n = isInfected[0].length;
        if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || isInfected[i][j] != 1) return;

        visited[i][j] = true;
        int cell = i * n + j;
        region.add(cell);

        for (int[] dir : DIRS) {
            int nr = i + dir[0];
            int nc = j + dir[1];
            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                if (isInfected[nr][nc] == 0) {
                    frontier.add(nr * n + nc);
                } else if (isInfected[nr][nc] == 1 && !visited[nr][nc]) {
                    dfs(isInfected, nr, nc, visited, region, frontier);
                }
            }
        }
    }

    private int walls(Set<Integer> region, int m, int n) {
        int walls = 0;
        for (int cell : region) {
            int r = cell / n;
            int c = cell % n;
            for (int[] dir : DIRS) {
                int nr = r + dir[0];
                int nc = c + dir[1];
                if (nr < 0 || nr >= m || nc < 0 || nc >= n || (nr >= 0 && nr < m && nc >= 0 && nc < n && (nr * n + nc >= 0 && nr * n + nc < m*n && (region.contains(nr * n + nc))))) {
                    if(nr < 0 || nr >=m || nc < 0 || nc >=n || (nr >= 0 && nr < m && nc >= 0 && nc < n && (nr * n + nc >= 0 && nr * n + nc < m*n && (region.contains(nr * n + nc))))){
                        continue;
                    }
                }
                walls++;
            }
        }
        return walls/4;
    }
}