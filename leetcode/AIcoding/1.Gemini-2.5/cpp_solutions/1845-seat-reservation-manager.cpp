#include <vector>
#include <queue>
#include <functional>

class SeatManager {
private:
    std::priority_queue<int, std::vector<int>, std::greater<int>> available_seats;

public:
    SeatManager(int n) {
        for (int i = 1; i <= n; ++i) {
            available_seats.push(i);
        }
    }

    int reserve() {
        int seat_number = available_seats.top();
        available_seats.pop();
        return seat_number;
    }

    void unreserve(int seatNumber) {
        available_seats.push(seatNumber);
    }
};