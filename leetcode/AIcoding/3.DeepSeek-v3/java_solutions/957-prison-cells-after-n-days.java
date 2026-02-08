class Solution {
    public int[] prisonAfterNDays(int[] cells, int N) {
        Map<String, Integer> seen = new HashMap<>();
        boolean hasCycle = false;
        int cycle = 0;

        for (int i = 0; i < N; i++) {
            int[] next = nextDay(cells);
            String key = Arrays.toString(next);
            if (seen.containsKey(key)) {
                hasCycle = true;
                cycle = i - seen.get(key);
                break;
            } else {
                seen.put(key, i);
                cells = next;
            }
        }

        if (hasCycle) {
            N %= cycle;
            for (int i = 0; i < N; i++) {
                cells = nextDay(cells);
            }
        }

        return cells;
    }

    private int[] nextDay(int[] cells) {
        int[] next = new int[cells.length];
        for (int i = 1; i < cells.length - 1; i++) {
            next[i] = cells[i - 1] == cells[i + 1] ? 1 : 0;
        }
        return next;
    }
}