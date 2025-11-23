class BookMyShow {
    private int[] seats;
    private int m;
    private int firstAvailableRow;

    public BookMyShow(int n, int m) {
        this.seats = new int[n];
        this.m = m;
        this.firstAvailableRow = 0;
    }

    public int[] gather(int k, int maxRow) {
        for (int i = firstAvailableRow; i <= maxRow; i++) {
            if (m - seats[i] >= k) {
                int startSeat = seats[i];
                seats[i] += k;
                return new int[]{i, startSeat};
            }
        }
        return new int[0];
    }

    public boolean scatter(int k, int maxRow) {
        long totalAvailable = 0;
        for (int i = firstAvailableRow; i <= maxRow; i++) {
            totalAvailable += m - seats[i];
            if (totalAvailable >= k) {
                break;
            }
        }
        if (totalAvailable < k) {
            return false;
        }

        int remaining = k;
        while (remaining > 0) {
            int available = m - seats[firstAvailableRow];
            if (available >= remaining) {
                seats[firstAvailableRow] += remaining;
                remaining = 0;
            } else {
                remaining -= available;
                seats[firstAvailableRow] = m;
                firstAvailableRow++;
            }
        }
        return true;
    }
}