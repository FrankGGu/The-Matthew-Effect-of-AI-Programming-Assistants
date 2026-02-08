import java.util.HashMap;
import java.util.Map;

class Spreadsheet {
    private Map<String, Integer> cells;

    public Spreadsheet() {
        cells = new HashMap<>();
    }

    public void set(int row, char column, int value) {
        String key = row + "," + column;
        cells.put(key, value);
    }

    public int get(int row, char column) {
        String key = row + "," + column;
        return cells.getOrDefault(key, 0);
    }

    public String getRow(int row) {
        StringBuilder result = new StringBuilder();
        for (char column = 'A'; column <= 'Z'; column++) {
            int value = get(row, column);
            result.append(value).append(",");
        }
        return result.length() > 0 ? result.substring(0, result.length() - 1) : "";
    }
}