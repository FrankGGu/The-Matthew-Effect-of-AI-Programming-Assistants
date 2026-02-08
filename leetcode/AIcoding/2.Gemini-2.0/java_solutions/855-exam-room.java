import java.util.TreeSet;

class ExamRoom {

    private int N;
    private TreeSet<Integer> seats;

    public ExamRoom(int n) {
        this.N = n;
        this.seats = new TreeSet<>();
    }

    public int seat() {
        if (seats.isEmpty()) {
            seats.add(0);
            return 0;
        }

        int first = seats.first();
        int maxDist = first;
        Integer prev = null;
        for (Integer seat : seats) {
            if (prev != null) {
                int dist = (seat - prev) / 2;
                if (dist > maxDist) {
                    maxDist = dist;
                }
            }
            prev = seat;
        }

        int last = N - 1;
        if (last - seats.last() > maxDist) {
            maxDist = last - seats.last();
        }

        int seatNum = 0;
        if (first == maxDist) {
            seatNum = 0;
        } else {
            prev = null;
            for (Integer seat : seats) {
                if (prev != null) {
                    int dist = (seat - prev) / 2;
                    if (dist == maxDist) {
                        seatNum = prev + dist;
                        break;
                    }
                }
                prev = seat;
            }
            if (seatNum == 0) {
                seatNum = N - 1;
            }
        }

        seats.add(seatNum);
        return seatNum;
    }

    public void leave(int p) {
        seats.remove(p);
    }
}