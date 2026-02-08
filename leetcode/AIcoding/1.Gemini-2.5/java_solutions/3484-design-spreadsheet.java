import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class Spreadsheet {

    private Cell[][] grid;
    private int rows;
    private int cols;

    private static class CellCoord {
        int r, c;

        public CellCoord(int r, int c) {
            this.r = r;
            this.c = c;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            CellCoord cellCoord = (CellCoord) o;
            return r == cellCoord.r && c == cellCoord.c;
        }

        @Override
        public int hashCode() {
            return Objects.hash(r, c);
        }
    }

    private static class Range {
        int r1, c1, r2, c2;

        public Range(int r1, int c1, int r2, int c2) {
            this.r1 = r1;
            this.c1 = c1;
            this.r2 = r2;
            this.c2 = c2;
        }
    }

    private static class Formula {
        enum Type { SUM, AVG }
        Type type;
        List<Range> ranges;

        private static final Pattern FORMULA_PATTERN = Pattern.compile("=(SUM|AVG)\\((.*)\\)");
        private static final Pattern RANGE_PART_PATTERN = Pattern.compile("(\\d+),(\\d+)(?::(\\d+),(\\d+))?");

        public Formula(String expr) {
            Matcher formulaMatcher = FORMULA_PATTERN.matcher(expr);
            if (!formulaMatcher.matches()) {
                throw new IllegalArgumentException("Invalid formula format: " + expr);
            }

            this.type = Type.valueOf(formulaMatcher.group(1).toUpperCase());
            String rangeStr = formulaMatcher.group(2);
            this.ranges = new ArrayList<>();

            Matcher rangePartMatcher = RANGE_PART_PATTERN.matcher(rangeStr);
            int lastEnd = 0;
            while (rangePartMatcher.find(lastEnd)) {
                int r1 = Integer.parseInt(rangePartMatcher.group(1)) - 1;
                int c1 = Integer.parseInt(rangePartMatcher.group(2)) - 1;
                String r2Str = rangePartMatcher.group(3);

                if (r2Str != null) {
                    int r2 = Integer.parseInt(r2Str) - 1;
                    int c2 = Integer.parseInt(rangePartMatcher.group(4)) - 1;
                    ranges.add(new Range(r1, c1, r2, c2));
                } else {
                    ranges.add(new Range(r1, c1, r1, c1));
                }
                lastEnd = rangePartMatcher.end();
                if (lastEnd < rangeStr.length() && rangeStr.charAt(lastEnd) == ',') {
                    lastEnd++;
                }
            }
        }
    }

    private class Cell {
        String expression;
        int value;
        List<CellCoord> directDependencies;
        Set<CellCoord> dependents;

        public Cell(String expression) {
            this.expression = expression;
            this.value = 0;
            this.directDependencies = new ArrayList<>();
            this.dependents = new HashSet<>();
        }
    }

    public Spreadsheet(int rows, int cols) {
        this.rows = rows;
        this.cols = cols;
        this.grid = new Cell[rows][cols];
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                grid[r][c] = new Cell("0");
            }
        }
        recalculateAllAffected(null);
    }

    public int get(int r, int c) {
        r--; c--;
        if (!isValidCoord(r, c)) {
            throw new IllegalArgumentException("Cell out of bounds: (" + (r + 1) + "," + (c + 1) + ")");
        }
        return grid[r][c].value;
    }

    public void set(int r, int c, String expr) {
        r--; c--;
        if (!isValidCoord(r, c)) {
            throw new IllegalArgumentException("Cell out of bounds: (" + (r + 1) + "," + (c + 1) + ")");
        }

        Cell targetCell = grid[r][c];
        targetCell.expression = expr;
        recalculateAllAffected(new CellCoord(r, c));
    }

    public void updateMatrix(int rows, int cols) {
        Cell[][] newGrid = new Cell[rows][cols];

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (r < this.rows && c < this.cols) {
                    newGrid[r][c] = this.grid[r][c];
                } else {
                    newGrid[r][c] = new Cell("0");
                }
            }
        }

        this.rows = rows;
        this.cols = cols;
        this.grid = newGrid;

        recalculateAllAffected(null);
    }

    private boolean isValidCoord(int r, int c) {
        return r >= 0 && r < rows && c >= 0 && c < cols;
    }

    private List<CellCoord> parseDependencies(String expression) {
        List<CellCoord> dependencies = new ArrayList<>();
        if (expression.startsWith("=")) {
            Formula formula = new Formula(expression);
            for (Range range : formula.ranges) {
                for (int r_iter = Math.min(range.r1, range.r2); r_iter <= Math.max(range.r1, range.r2); r_iter++) {
                    for (int c_iter = Math.min(range.c1, range.c2); c_iter <= Math.max(range.c1, range.c2); c_iter++) {
                        dependencies.add(new CellCoord(r_iter, c_iter));
                    }
                }
            }
        }
        return dependencies;
    }

    private void recalculateAllAffected(CellCoord startCoord) {
        Set<CellCoord> affectedCells = new HashSet<>();
        if (startCoord == null) {
            for (int r = 0; r < rows; r++) {
                for (int c = 0; c < cols; c++) {
                    affectedCells.add(new CellCoord(r, c));
                }
            }
        } else {
            Queue<CellCoord> q = new LinkedList<>();
            q.offer(startCoord);
            affectedCells.add(startCoord);

            while (!q.isEmpty()) {
                CellCoord current = q.poll();
                for (CellCoord dependent : grid[current.r][current.c].dependents) {
                    if (isValidCoord(dependent.r, dependent.c) && !affectedCells.contains(dependent)) {
                        affectedCells.add(dependent);
                        q.offer(dependent);
                    }
                }
            }
        }

        Stack<CellCoord> topoOrder = new Stack<>();
        Set<CellCoord> tempVisited = new HashSet<>();
        Set<CellCoord> cycleDetect = new HashSet<>();

        for (CellCoord coord : affectedCells) {
            if (!tempVisited.contains(coord)) {
                dfsTopologicalSort(coord.r, coord.c, tempVisited, cycleDetect, topoOrder, affectedCells);
            }
        }

        while (!topoOrder.isEmpty()) {
            CellCoord coord = topoOrder.pop();
            recalculateSingleCell(coord.r, coord.c);
        }
    }

    private void dfsTopologicalSort(int r, int c, Set<CellCoord> tempVisited, Set<CellCoord> cycleDetect, Stack<CellCoord> topoOrder, Set<CellCoord> affectedCells) {
        CellCoord currentCoord = new CellCoord(r, c);

        if (cycleDetect.contains(currentCoord)) {
            if (affectedCells.contains(currentCoord)) {
                grid[r][c].value = 0; 
            }
            return;
        }
        if (tempVisited.contains(currentCoord)) {
            return;
        }

        tempVisited.add(currentCoord);
        cycleDetect.add(currentCoord);

        List<CellCoord> currentDependencies = parseDependencies(grid[r][c].expression);
        for (CellCoord depCoord : currentDependencies) {
            if (isValidCoord(depCoord.r, depCoord.c)) {
                dfsTopologicalSort(depCoord.r, depCoord.c, tempVisited, cycleDetect, topoOrder, affectedCells);
            }
        }

        cycleDetect.remove(currentCoord);

        if (affectedCells.contains(currentCoord)) {
            topoOrder.push(currentCoord);
        }
    }

    private void recalculateSingleCell(int r, int c) {
        Cell currentCell = grid[r][c];

        for (CellCoord oldDep : currentCell.directDependencies) {
            if (isValidCoord(oldDep.r, oldDep.c)) {
                grid[oldDep.r][oldDep.c].dependents.remove(new CellCoord(r, c));
            }
        }
        currentCell.directDependencies.clear();

        if (currentCell.expression.startsWith("=")) {
            Formula formula = new Formula(currentCell.expression);
            long sum = 0;
            int count = 0;

            for (Range range : formula.ranges) {
                for (int r_iter = Math.min(range.r1, range.r2); r_iter <= Math.max(range.r1, range.r2); r_iter++) {
                    for (int c_iter = Math.min(range.c1, range.c2); c_iter <= Math.max(range.c1, range.c2); c_iter++) {
                        CellCoord depCoord = new CellCoord(r_iter, c_iter);
                        if (isValidCoord(depCoord.r, depCoord.c)) {
                            currentCell.directDependencies.add(depCoord);
                            grid[depCoord.r][depCoord.c].dependents.add(new CellCoord(r, c));

                            sum += grid[depCoord.r][depCoord.c].value;
                            count++;
                        }
                    }
                }
            }

            if (formula.type == Formula.Type.SUM) {
                currentCell.value = (int) sum;
            } else {
                currentCell.value = (count == 0) ? 0 : (int) (sum / count);
            }
        } else {
            currentCell.value = Integer.parseInt(currentCell.expression);
        }
    }
}