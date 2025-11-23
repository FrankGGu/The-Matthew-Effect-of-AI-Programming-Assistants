class SeatManager {
public:
    priority_queue<int, vector<int>, greater<int>> availableSeats;
    int nextSeat;

    SeatManager(int n) {
        nextSeat = 1;
        for (int i = 1; i <= n; ++i) {
            availableSeats.push(i);
        }
    }

    int reserve() {
        int seat = availableSeats.top();
        availableSeats.pop();
        return seat;
    }

    void unreserve(int seatNumber) {
        availableSeats.push(seatNumber);
    }
};