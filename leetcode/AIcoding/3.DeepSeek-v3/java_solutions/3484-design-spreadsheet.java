class Excel {
    private int[][] data;
    private Map<String, String[]> sumMap;

    public Excel(int height, char width) {
        data = new int[height][width - 'A' + 1];
        sumMap = new HashMap<>();
    }

    public void set(int row, char column, int val) {
        int col = column - 'A';
        String key = row + "," + col;
        sumMap.remove(key);
        data[row - 1][col] = val;
    }

    public int get(int row, char column) {
        int col = column - 'A';
        String key = row + "," + col;
        if (sumMap.containsKey(key)) {
            return sum(row, column, sumMap.get(key));
        }
        return data[row - 1][col];
    }

    public int sum(int row, char column, String[] numbers) {
        int col = column - 'A';
        String key = row + "," + col;
        sumMap.put(key, numbers);
        int sum = 0;
        for (String s : numbers) {
            if (s.contains(":")) {
                String[] parts = s.split(":");
                int r1 = Integer.parseInt(parts[0].substring(1));
                int c1 = parts[0].charAt(0) - 'A';
                int r2 = Integer.parseInt(parts[1].substring(1));
                int c2 = parts[1].charAt(0) - 'A';
                for (int i = r1; i <= r2; i++) {
                    for (int j = c1; j <= c2; j++) {
                        sum += get(i, (char)('A' + j));
                    }
                }
            } else {
                int r = Integer.parseInt(s.substring(1));
                char c = s.charAt(0);
                sum += get(r, c);
            }
        }
        data[row - 1][col] = sum;
        return sum;
    }
}