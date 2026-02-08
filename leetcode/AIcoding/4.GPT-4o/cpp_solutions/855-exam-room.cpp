#include <vector>
#include <set>

class ExamRoom {
public:
    int N;
    std::set<int> seats;

    ExamRoom(int N) {
        this->N = N;
    }

    int seat() {
        if (seats.empty()) {
            seats.insert(0);
            return 0;
        }

        int maxDist = 0, seatToTake = 0;
        int prev = -1, first = *seats.begin();

        if (first > 0) {
            maxDist = first; 
            seatToTake = 0;
        }

        for (int s : seats) {
            if (prev != -1) {
                int dist = (s - prev) / 2;
                if (dist > maxDist) {
                    maxDist = dist;
                    seatToTake = prev + dist;
                }
            }
            prev = s;
        }

        if (prev < N - 1) {
            int dist = N - 1 - prev;
            if (dist > maxDist) {
                seatToTake = N - 1;
            }
        }

        seats.insert(seatToTake);
        return seatToTake;
    }

    void leave(int p) {
        seats.erase(p);
    }
};