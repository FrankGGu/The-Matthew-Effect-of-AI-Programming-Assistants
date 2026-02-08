import java.util.PriorityQueue;
import java.util.TreeSet;

class ExamRoom {

    private int N;
    private TreeSet<Integer> seated; // Stores occupied seat indices
    private PriorityQueue<Gap> pq; // Stores available gaps, ordered by max_min_distance, then min_seat_index

    // Represents an empty segment between two occupied seats (or virtual walls -1 and N)
    private class Gap {
        int p1, p2; // p1: left occupied seat (or -1 for left wall), p2: right occupied seat (or N for right wall)
        int dist;   // The maximized minimum distance achieved by placing a seat in this gap
        int seat;   // The index of the seat that achieves this max_min_distance

        public Gap(int p1, int p2, int N_total) {
            this.p1 = p1;
            this.p2 = p2;

            // Calculate the optimal seat and its distance for this gap
            // The optimal seat is in the middle of the interval (p1, p2)
            this.seat = p1 + (p2 - p1) / 2;
            this.dist = (p2 - p1) / 2;
        }
    }

    public ExamRoom(int n) {
        this.N = n;
        this.seated = new TreeSet<>();
        this.pq = new PriorityQueue<>((a, b) -> {
            if (a.dist != b.dist) {
                return b.dist - a.dist; // Max distance first
            }
            return a.seat - b.seat; // Tie-breaker: smaller seat index
        });

        // Initially, the entire room is one large gap from virtual wall -1 to virtual wall N
        pq.offer(new Gap(-1, N, N));
    }

    public int seat() {
        int p = -1;
        Gap bestGap = null;

        // Use lazy deletion: poll gaps until a valid one is found
        while (true) {
            bestGap = pq.poll();
            p = bestGap.seat;

            // Validate if this gap is still relevant (i.e., its endpoints are still correct)
            Integer actualP1 = seated.lower(p); // Largest element < p
            Integer actualP2 = seated.higher(p); // Smallest element > p

            // Check if bestGap.p1 matches actualP1 (or -1 if actualP1 is null)
            boolean p1Matches = (bestGap.p1 == -1 && actualP1 == null) || (actualP1 != null && actualP1 == bestGap.p1);
            // Check if bestGap.p2 matches actualP2 (or N if actualP2 is null)
            boolean p2Matches = (bestGap.p2 == N && actualP2 == null) || (actualP2 != null && actualP2 == bestGap.p2);

            if (p1Matches && p2Matches) {
                // This gap is still valid, take the seat
                break;
            }
            // If not valid, it's stale; discard it and try the next best gap
        }

        seated.add(p);

        // Add two new gaps created by taking seat p
        // Left gap: from bestGap.p1 to p
        pq.offer(new Gap(bestGap.p1, p, N));
        // Right gap: from p to bestGap.p2
        pq.offer(new Gap(p, bestGap.p2, N));

        return p;
    }

    public void leave(int p) {
        seated.remove(p);

        // Find neighbors of p that are now exposed
        Integer prev = seated.lower(p);
        Integer next = seated.higher(p);

        // The two gaps that were formed when p was seated are now invalid.
        // We don't explicitly remove them from the PQ; they will be lazily deleted in seat().

        // Add the new merged gap (from prev to next)
        pq.offer(new Gap((prev == null) ? -1 : prev, (next == null) ? N : next, N));
    }
}