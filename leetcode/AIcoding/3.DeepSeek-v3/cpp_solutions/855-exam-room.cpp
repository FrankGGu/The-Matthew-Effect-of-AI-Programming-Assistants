class ExamRoom {
private:
    set<int> seats;
    int N;

public:
    ExamRoom(int N) : N(N) {}

    int seat() {
        if (seats.empty()) {
            seats.insert(0);
            return 0;
        }
        int maxDist = *seats.begin();
        int prev = *seats.begin();
        int seat = 0;
        for (auto curr : seats) {
            int dist = (curr - prev) / 2;
            if (dist > maxDist) {
                maxDist = dist;
                seat = prev + dist;
            }
            prev = curr;
        }
        if (N - 1 - prev > maxDist) {
            seat = N - 1;
        }
        seats.insert(seat);
        return seat;
    }

    void leave(int p) {
        seats.erase(p);
    }
};