public class Solution {

import java.util.*;

public class ExamRoom {
    private int N;
    private TreeSet<Integer> seats;

    public ExamRoom(int N) {
        this.N = N;
        this.seats = new TreeSet<>();
    }

    public int seat() {
        if (seats.isEmpty()) {
            seats.add(0);
            return 0;
        }

        int prev = -1;
        int maxDist = 0;
        int result = 0;

        for (int seat : seats) {
            if (prev == -1) {
                if (seat != 0) {
                    maxDist = seat;
                    result = 0;
                }
            } else {
                int dist = (seat - prev) / 2;
                if (dist > maxDist) {
                    maxDist = dist;
                    result = prev + dist;
                }
            }
            prev = seat;
        }

        if (prev != N - 1) {
            if (N - 1 - prev > maxDist) {
                result = N - 1;
            }
        }

        seats.add(result);
        return result;
    }

    public void leave(int p) {
        seats.remove(p);
    }
}
}