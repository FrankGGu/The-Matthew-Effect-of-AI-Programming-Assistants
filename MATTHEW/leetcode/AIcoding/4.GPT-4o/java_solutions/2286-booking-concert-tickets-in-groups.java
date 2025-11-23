import java.util.*;

class BookMyShow {
    private int[] seats;
    private int totalRows;
    private int totalCols;
    private int currentRow;

    public BookMyShow(int n, int m) {
        this.seats = new int[n];
        this.totalRows = n;
        this.totalCols = m;
        this.currentRow = 0;
    }

    public int[] gather(int k, int maxRow) {
        for (int i = Math.min(maxRow, totalRows) - 1; i >= 0; i--) {
            if (seats[i] + k <= totalCols) {
                int startCol = seats[i];
                seats[i] += k;
                return new int[] {i, startCol};
            }
        }
        return new int[] {-1, -1};
    }

    public boolean scatter(int k, int maxRow) {
        for (int i = 0; i < Math.min(maxRow, totalRows); i++) {
            if (seats[i] + k <= totalCols) {
                seats[i] += k;
                return true;
            }
        }
        return false;
    }
}