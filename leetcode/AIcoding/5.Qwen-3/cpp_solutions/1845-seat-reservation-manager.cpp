#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    class SeatManager {
    private:
        priority_queue<int, vector<int>, greater<int>> availableSeats;
        int nextSeat;

    public:
        SeatManager(int n) : nextSeat(1) {
            for (int i = 1; i <= n; ++i) {
                availableSeats.push(i);
            }
        }

        int reserve() {
            int seat = availableSeats.top();
            availableSeats.pop();
            return seat;
        }

        void unreserve(int seat) {
            availableSeats.push(seat);
        }
    };

    SeatManager* create(int n) {
        return new SeatManager(n);
    }
};