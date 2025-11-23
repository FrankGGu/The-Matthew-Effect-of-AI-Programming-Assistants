class BookMyShow {
public:
    vector<int> rows;
    int totalRows, totalSeats;

    BookMyShow(int n, int m) {
        totalRows = n;
        totalSeats = m;
        rows.assign(n, m);
    }

    vector<int> gather(int k, int maxRow) {
        for (int i = 0; i < min(maxRow, totalRows); i++) {
            if (rows[i] >= k) {
                rows[i] -= k;
                return {i, totalSeats - rows[i] - k};
            }
        }
        return {};
    }

    bool scatter(int k, int maxRow) {
        for (int i = 0; i < min(maxRow, totalRows); i++) {
            if (rows[i] >= 1) {
                int seatsToTake = min(rows[i], k);
                rows[i] -= seatsToTake;
                k -= seatsToTake;
                if (k == 0) return true;
            }
        }
        return false;
    }
};