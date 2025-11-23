#include <set>

class SeatManager {
public:
    std::set<int> availableSeats;
    int last = 0;

    SeatManager(int n) {
        last = 0;
    }

    int reserve() {
        if (availableSeats.empty()) {
            return ++last;
        } else {
            int seat = *availableSeats.begin();
            availableSeats.erase(availableSeats.begin());
            return seat;
        }
    }

    void unreserve(int seatNumber) {
        availableSeats.insert(seatNumber);
    }
};