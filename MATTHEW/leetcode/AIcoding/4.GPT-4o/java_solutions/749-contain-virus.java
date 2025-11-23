import java.util.*;

class Solution {
    public int containVirus(int[][] isInfected) {
        int m = isInfected.length, n = isInfected[0].length;
        int totalWalls = 0;

        while (true) {
            boolean found = false;
            int[][] visited = new int[m][n];
            List<int[]> wallsNeeded = new ArrayList<>();
            List<Integer> infectedRegions = new ArrayList<>();
            List<Integer> wallsCount = new ArrayList<>();

            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (isInfected[i][j] == 1 && visited[i][j] == 0) {
                        found = true;
                        int walls = 0;
                        Queue<int[]> queue = new LinkedList<>();
                        queue.offer(new int[]{i, j});
                        visited[i][j] = 1;
                        List<int[]> region = new ArrayList<>();

                        while (!queue.isEmpty()) {
                            int[] cell = queue.poll();
                            region.add(cell);
                            for (int[] dir : new int[][]{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}) {
                                int ni = cell[0] + dir[0], nj = cell[1] + dir[1];
                                if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                                    if (isInfected[ni][nj] == 1 && visited[ni][nj] == 0) {
                                        visited[ni][nj] = 1;
                                        queue.offer(new int[]{ni, nj});
                                    } else if (isInfected[ni][nj] == 0) {
                                        walls++;
                                    }
                                }
                            }
                        }

                        infectedRegions.add(region.size());
                        wallsCount.add(walls);
                        wallsNeeded.addAll(region);
                    }
                }
            }

            if (!found) break;

            int maxWalls = -1, maxIndex = -1;
            for (int i = 0; i < wallsCount.size(); i++) {
                if (wallsCount.get(i) > maxWalls) {
                    maxWalls = wallsCount.get(i);
                    maxIndex = i;
                }
            }

            totalWalls += wallsCount.get(maxIndex);
            Set<int[]> toContain = new HashSet<>(wallsNeeded);

            for (int i = 0; i < wallsNeeded.size(); i++) {
                int[] cell = wallsNeeded.get(i);
                if (infectedRegions.get(i) != infectedRegions.get(maxIndex)) {
                    isInfected[cell[0]][cell[1]] = -1;
                }
            }

            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (isInfected[i][j] == 1) {
                        for (int[] dir : new int[][]{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}) {
                            int ni = i + dir[0], nj = j + dir[1];
                            if (ni >= 0 && ni < m && nj >= 0 && nj < n && isInfected[ni][nj] == 0) {
                                isInfected[ni][nj] = 1;
                            }
                        }
                    }
                }
            }

            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (isInfected[i][j] == -1) {
                        isInfected[i][j] = 0;
                    }
                }
            }
        }

        return totalWalls;
    }
}