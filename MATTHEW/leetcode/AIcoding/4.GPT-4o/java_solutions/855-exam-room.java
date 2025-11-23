import java.util.TreeSet;

class ExamRoom {
    private TreeSet<Integer> seats;
    private int N;

    public ExamRoom(int N) {
        this.N = N;
        this.seats = new TreeSet<>();
    }

    public int seat() {
        if (seats.isEmpty()) {
            seats.add(0);
            return 0;
        }

        int maxDist = 0, seat = 0;
        Integer prev = -1;

        for (int s : seats) {
            int dist = (s - prev) / 2;
            if (dist > maxDist) {
                maxDist = dist;
                seat = prev == -1 ? 0 : prev + dist;
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