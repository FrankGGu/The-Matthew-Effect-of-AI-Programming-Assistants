class Spreadsheet {

    private String[][] spreadsheet;
    private Map<String, String> formulaMap;

    public Spreadsheet(int rows, char cols) {
        spreadsheet = new String[rows][cols - 'A' + 1];
        formulaMap = new HashMap<>();
    }

    public void set(int row, char col, String s) {
        spreadsheet[row - 1][col - 'A'] = s;
        String cell = col + String.valueOf(row);
        if (formulaMap.containsKey(cell)) {
            formulaMap.remove(cell);
        }
    }

    public String get(int row, char col) {
        String cell = col + String.valueOf(row);
        if (formulaMap.containsKey(cell)) {
            String formula = formulaMap.get(cell);
            return evaluate(formula);
        }
        return spreadsheet[row - 1][col - 'A'] == null ? "" : spreadsheet[row - 1][col - 'A'];
    }

    public void setFormula(int row, char col, String formula) {
        String cell = col + String.valueOf(row);
        formulaMap.put(cell, formula);
        spreadsheet[row - 1][col - 'A'] = null;
    }

    private String evaluate(String formula) {
        String[] cells = formula.split("\\+");
        int sum = 0;
        for (String cell : cells) {
            cell = cell.trim();
            int row = Integer.parseInt(cell.substring(1));
            char col = cell.charAt(0);
            String value = get(row, col);
            if (value.isEmpty()) {
                sum += 0;
            } else {
                sum += Integer.parseInt(value);
            }
        }
        return String.valueOf(sum);
    }
}