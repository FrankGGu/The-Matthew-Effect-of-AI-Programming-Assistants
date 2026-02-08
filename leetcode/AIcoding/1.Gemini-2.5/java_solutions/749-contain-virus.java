import java.util.*;

class Solution {
    int R, C;
    int[][] grid;
    boolean[][] visited;
    int[] dr = {-1, 1, 0, 0};
    int[] dc = {0, 0, -1, 1};

    class RegionInfo {
        List<int[]> cellsInRegion = new ArrayList<>();
        Set<Integer> cellsToInfect = new HashSet<>(); // Stores r*C + c
        int wallsNeeded = 0;
    }

    public int containVirus(int[][] grid) {
        this.grid = grid;
        R = grid.length;
        C = grid[0].length;

        int totalWalls = 0;

        while (true) {
            visited = new boolean[R][C];
            List<RegionInfo> regions = new ArrayList<>();

            for (int r = 0; r < R; r++) {
                for (int c = 0; c < C; c++) {
                    if (grid[r][c] == 1 && !visited[r][c]) {
                        RegionInfo currentRegion = new RegionInfo();

                        Queue<int[]> q = new LinkedList<>();
                        q.offer(new int[]{r, c});
                        visited[r][c] = true;
                        currentRegion.cellsInRegion.add(new int[]{r, c});

                        while (!q.isEmpty()) {
                            int[] curr = q.poll();
                            int currR = curr[0];
                            int currC = curr[1];

                            for (int i = 0; i < 4; i++) {
                                int nr = currR + dr[i];
                                int nc = currC + dc[i];

                                if (nr >= 0 && nr < R && nc >= 0 && nc < C) {
                                    if (grid[nr][nc] == 1 && !visited[nr][nc]) {
                                        visited[nr][nc] = true;
                                        q.offer(new int[]{nr, nc});
                                        currentRegion.cellsInRegion.add(new int[]{nr, nc});
                                    } else if (grid[nr][nc] == 0) { // Healthy cell
                                        currentRegion.cellsToInfect.add(nr * C + nc);
                                    }
                                }
                            }
                        }

                        if (!currentRegion.cellsToInfect.isEmpty()) {
                            currentRegion.wallsNeeded = currentRegion.cellsToInfect.size();
                            regions.add(currentRegion);
                        }
                    }
                }
            }

            if (regions.isEmpty()) {
                break; // No more active virus regions
            }

            RegionInfo bestRegion = null;
            int maxInfections = -1;
            for (RegionInfo region : regions) {
                if (region.cellsToInfect.size() > maxInfections) {
                    maxInfections = region.cellsToInfect.size();
                    bestRegion = region;
                }
            }

            if (maxInfections == 0) {
                break; // No region can infect new cells
            }

            totalWalls += bestRegion.wallsNeeded;
            for (int[] cell : bestRegion.cellsInRegion) {
                grid[cell[0]][cell[1]] = -1; // Mark as contained
            }

            for (RegionInfo region : regions) {
                if (region != bestRegion) {
                    for (int encodedCell : region.cellsToInfect) {
                        int r = encodedCell / C;
                        int c = encodedCell % C;
                        if (grid[r][c] == 0) { // Only infect if still healthy
                            grid[r][c] = 1;
                        }
                    }
                }
            }
        }

        return totalWalls;
    }
}