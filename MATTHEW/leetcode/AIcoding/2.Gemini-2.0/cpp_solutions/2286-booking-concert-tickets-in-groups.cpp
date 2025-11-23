#include <vector>
#include <set>

using namespace std;

class BookMyShow {
public:
    int n, m;
    vector<long long> sum;
    set<int> availableRows;

    BookMyShow(int n, int m) : n(n), m(m), sum(n, 0) {
        availableRows.clear();
        for (int i = 0; i < n; ++i) {
            availableRows.insert(i);
        }
    }

    int gather(int k, int maxRow) {
        for (int i = 0; i <= maxRow; ++i) {
            if (m - sum[i] >= k) {
                int row = i;
                sum[i] += k;
                if (m - sum[i] == 0) {
                    availableRows.erase(i);
                }
                return row;
            }
        }
        return -1;
    }

    bool scatter(int k, int maxRow) {
        long long availableSeats = 0;
        for (auto it = availableRows.begin(); it != availableRows.end(); ++it) {
            if (*it > maxRow) break;
            availableSeats += m - sum[*it];
        }

        if (availableSeats < k) {
            return false;
        }

        for (auto it = availableRows.begin(); it != availableRows.end();) {
            if (*it > maxRow) break;
            int row = *it;
            long long seatsToBook = min((long long)k, (long long)m - sum[row]);
            sum[row] += seatsToBook;
            k -= seatsToBook;
            if (m - sum[row] == 0) {
                it = availableRows.erase(it);
            } else {
                ++it;
            }

            if (k == 0) {
                return true;
            }
        }

        return true;
    }
};