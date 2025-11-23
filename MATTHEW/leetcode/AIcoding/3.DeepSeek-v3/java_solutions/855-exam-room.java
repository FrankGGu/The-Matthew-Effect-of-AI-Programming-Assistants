import java.util.TreeSet;

class ExamRoom {
    private TreeSet<Integer> seats;
    private int N;

    public ExamRoom(int N) {
        this.seats = new TreeSet<>();
        this.N = N;
    }

    public int seat() {
        if (seats.isEmpty()) {
            seats.add(0);
            return 0;
        }
        int prev = -1;
        int maxDist = seats.first();
        int seat = 0;
        for (int s : seats) {
            if (prev != -1) {
                int d = (s - prev) / 2;
                if (d > maxDist) {
                    maxDist = d;
                    seat = prev + d;
                }
            }
            prev = s;
        }
        if (N - 1 - seats.last() > maxDist) {
            seat = N - 1;
        }
        seats.add(seat);
        return seat;
    }

    public void leave(int p) {
        seats.remove(p);
    }
}